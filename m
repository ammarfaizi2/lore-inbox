Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVCZWsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVCZWsr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 17:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVCZWsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 17:48:47 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:24227 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261327AbVCZWsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 17:48:45 -0500
Date: Sat, 26 Mar 2005 23:48:32 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@osdl.org>
Subject: Re: sparse segfaults
Message-ID: <Pine.LNX.4.61.0503262339400.3278@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


on Nov 22 2004, Linus Torvalds wrote 
( http://groups-beta.google.com/group/linux.kernel/brow
se_frm/thread/32c75ae8dd925ce7/5ca16f581a293fab?tvc=1#5ca16f581a293fab ):

>Same goes for the "extended lvalues". They are not only insane, but they
>mean that code like [...]


Well, here [http://gcc.gnu.org/gcc-3.4/changes.html] are some things (section 
"C/Objective C/C++") that will be deprecated, including ?: as an lvalue and
the behated (a,b)-as-lvalue.  ;-)


Cheers,
Jan Engelhardt
-- 
No TOFU for me, please.
