Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262797AbVG3CFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbVG3CFN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 22:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbVG3CFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 22:05:09 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:40634 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262787AbVG3CDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 22:03:32 -0400
Date: Sat, 30 Jul 2005 03:03:24 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: S3 resume and serial console..
Message-ID: <Pine.LNX.4.58.0507300301370.13092@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay I'm really trying here but my PC really hates me :-)

I've set up an i865 machine with a serial console, and on-board graphics
(also have radeon/MGA AGP..) and in an effort to try and figure out some
more about suspend /resume to RAM..

However now the  serial port doesn't come back after resume, I just get
garbage sent out on it ...

Anyone any ideas?

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

