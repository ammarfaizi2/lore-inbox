Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132831AbRDITlj>; Mon, 9 Apr 2001 15:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132832AbRDITl3>; Mon, 9 Apr 2001 15:41:29 -0400
Received: from violin.dcs.uky.edu ([204.198.75.11]:32955 "EHLO
	violin.dcs.uky.edu") by vger.kernel.org with ESMTP
	id <S132831AbRDITlM>; Mon, 9 Apr 2001 15:41:12 -0400
Date: Mon, 9 Apr 2001 15:41:11 -0400 (EDT)
From: Srinivasan Venkatraman <srini@dcs.uky.edu>
To: linux-kernel@vger.kernel.org
Subject: Question on accessing /proc
Message-ID: <Pine.LNX.4.10.10104091537190.18228-100000@bart.dcs.uky.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

 I am new to this list. I did go through the FAQ before posting this
question. I have a specific requirment - creating,modifying and deleting
data structures inside the kernel values of which will be passed by an
user application. I know we could do this by writing a system call or by
ioctl command to a character device. My question is can we do this by
writing to /proc file system ? Can we actually create, modify and delete
data structures by accessing this file system ?
 Any pointers will be appreciated.

Thanks,
Srini.

