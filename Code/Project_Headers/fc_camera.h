/*
 * fc_camera.h
 *
 *  Created on: Dec 1, 2014
 *      Author: Admin
 */

#ifndef FC_CAMERA_H_
#define FC_CAMERA_H_

#include <stdio.h>
#include <string.h>

struct return_struct{
	unsigned int lines[10][2];
};

static void fcc_debug_print_array(int data[128], char name[]);

static void fcc_debug_print_array_d(double data[128], char name[]);

extern void fcc_set_debug(int debug_mode);

extern struct return_struct fcc_get_line_data(int raw_camera_line[128]);

#endif /* FC_CAMERA_H_ */
