Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281835AbRLAWAp>; Sat, 1 Dec 2001 17:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281773AbRLAWAf>; Sat, 1 Dec 2001 17:00:35 -0500
Received: from host113.south.iit.edu ([216.47.130.113]:12928 "EHLO
	lostlogicx.com") by vger.kernel.org with ESMTP id <S281772AbRLAWAY>;
	Sat, 1 Dec 2001 17:00:24 -0500
Message-ID: <3C0952F5.2050802@twobit.net>
Date: Sat, 01 Dec 2001 16:00:21 -0600
From: Lost Logic <lostlogic@twobit.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: rivafb
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all you smart folk.
    I've been trying to use the rivafb driver for my console, because I 
like 1024x768 console resolution, but dislike the slowness of the vesa 
framebuffer.  Every time I start X and then switch to a text console, it 
begins to mess up (my cursor turns into 2 purple dots) and if I try to 
switch back to X the console is completely corrupted, forcing me to 
reboot.  Is there a conflict that makes it incorrect to use a 
framebuffer text console and a different accelerated X console?  Or is 
this a bug in the memory handling of the rivafb that makes it conflict 
with the NVidia accelerated stuff, OR can I not ask this here, because 
I'm using the unlicensed NVidia kernel drivers?

Thanks!

