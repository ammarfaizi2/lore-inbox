Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTFUF0B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 01:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbTFUF0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 01:26:00 -0400
Received: from web10704.mail.yahoo.com ([216.136.130.212]:4207 "HELO
	web10704.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262033AbTFUFZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 01:25:58 -0400
Message-ID: <20030621054000.66503.qmail@web10704.mail.yahoo.com>
Date: Fri, 20 Jun 2003 22:40:00 -0700 (PDT)
From: BalaKrishna Mallipeddi <bkmallipeddi@yahoo.com>
Subject: Bad address problem while reading from hard disk(using sys_read).
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I developed a kernel module. Within that i am
dynamically allocating memory(using kmalloc and
vmalloc) for a buffer to read data. After that while
trying to read into this buffer from the hard disk
using sys_read i am getting an error. And the same
error i am getting while writing into another buffer,
which was allocated in the same way, using sys_write.
The error number set is -14(EFAULT) i.e., Bad address.


   Give me any idea to resolve the problem.

  If anyone help me i am gretful to them.

Thanks & Regards


=====
BalaKrishna Mallipeddi
Member Technical Staff Software
Innomedia Technologies Pvt. Ltd.,
#3278, 12th Main, HAL 2nd stage,
Bangalore-560008,
INDIA
Phone : 5278389 + 123

__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
