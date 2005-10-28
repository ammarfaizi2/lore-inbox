Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVJ1VzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVJ1VzK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVJ1VzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:55:10 -0400
Received: from sccrmhc11.comcast.net ([63.240.77.81]:23190 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750773AbVJ1VzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:55:09 -0400
Mime-Version: 1.0 (Apple Message framework v734)
Content-Transfer-Encoding: 7bit
Message-Id: <15DF6933-2475-439D-BE0A-DC232B92FDB7@comcast.net>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: PPC32 - No IDE/ATA devices on new PowerBook
Date: Fri, 28 Oct 2005 17:55:01 -0400
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't seem to get the kernel to detect the IDE CDROM and Hard-disk  
at all on the latest (5,8) PowerBook revision - no IDE controller is  
reported in the dmesg. I have tried 2.6.8 from debian as well as  
2.6.12x from Ubuntu and Gentoo.

Both  the HDD and CDROM drives look fairly routine stuff to me  
although I am not sure what kind of IDE controller is inside..

Is there any point in trying newer kernels?

Parag
