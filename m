Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbWISRIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbWISRIl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 13:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWISRIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 13:08:41 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:61677 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S1030327AbWISRIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 13:08:40 -0400
From: Allan Zhong <allanz@cse.unsw.EDU.AU>
To: linux-kernel@vger.kernel.org
Date: Wed, 20 Sep 2006 03:08:38 +1000 (EST)
X-X-Sender: allanz@wagner.orchestra.cse.unsw.EDU.AU
Subject: Help with initrd files and grub boot
Message-ID: <Pine.LNX.4.64.0609200308100.14271@wagner.orchestra.cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I compile the kernel and made a image and then installed the kernel, but 
unforunately i wasn't able to load into the operating system. It seems 
that they problem concerns the lack of initrd files. Btw i've made a image 
for the debian distribution as this is the one im using. Anyhow i used 
these commands.

make dep
make-kpkg clean
fakeroot make-kpkg --revision=custom.1.0 kernel_image
make clean

Then i get this image file title "kernel-imge-2.6.17_custom.1.0_i486.deb"

So how do i make one of those initrd files.

Any help would be appreciated.

Cheers,
Sleek
