Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268329AbUHaNWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268329AbUHaNWz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 09:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268144AbUHaNWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 09:22:54 -0400
Received: from web50605.mail.yahoo.com ([206.190.38.92]:42326 "HELO
	web50605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268473AbUHaNWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 09:22:34 -0400
Message-ID: <20040831132231.42454.qmail@web50605.mail.yahoo.com>
Date: Tue, 31 Aug 2004 06:22:31 -0700 (PDT)
From: Jeba Anandhan A <jeba_career@yahoo.com>
Subject: Superblock Creation
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

how to write a kernel module program to create a
superblock object and manipulate data structures of
superblock of existing superblock.

like
#include<linux/kernel.h>
#include<linux/module.h>
int init_module(void){
struct super_block *my_super;
my->super="/dev/hda1"; // i dont know whether it is
//correct
}
...
how to access the superblock object of /dev/hda1 which
is located in memory and disk.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
