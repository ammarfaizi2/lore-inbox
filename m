Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262005AbTDADzT>; Mon, 31 Mar 2003 22:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262006AbTDADzS>; Mon, 31 Mar 2003 22:55:18 -0500
Received: from web20513.mail.yahoo.com ([216.136.174.44]:36932 "HELO
	web20513.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262005AbTDADzS>; Mon, 31 Mar 2003 22:55:18 -0500
Message-ID: <20030401040641.77875.qmail@web20513.mail.yahoo.com>
Date: Mon, 31 Mar 2003 20:06:41 -0800 (PST)
From: raman deep <ramands2110@yahoo.com>
Subject: Compilation Error my_ops has intializer but incomplete type
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 
i am trying to write device driver on linux kernel 2.4
redhat distribution 

iam getting compilation errors for driver code.
struct file_operations my_ops
={NULL,my_read,my_write,NULL,NULL,NULL
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
NULL };
ERROR -> my_ops has intializer but incomplete type
Can u help with this 
Regards
Raman

__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://platinum.yahoo.com
