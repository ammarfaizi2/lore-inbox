Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbTH0WSY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 18:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTH0WSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 18:18:24 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:19707 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S262425AbTH0WSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 18:18:17 -0400
Date: Wed, 27 Aug 2003 23:09:50 +0100
From: Dave Bentham <dave.bentham@ntlworld.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: kernel 2.4.22 IDE/SCSI CDRW crashing still
Message-Id: <20030827230950.7b7c0ca0.dave@telekon>
In-Reply-To: <200306162148.h5GLmXsN002578@telekon.davesnet>
References: <200306162148.h5GLmXsN002578@telekon.davesnet>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am still getting the kernel panic when mounting my CD-RW
drive (ide-scsi) with 2.4.22. This is the one that appeared with 2.4.21.
I'm not an expert on these things but I got the impression this was
being addressed but I have been off the list since reporting it with
2.4.21. Am I mistaken? Or has my 2.4.22 build perhaps gone awry?

Dave


On Mon, 16 Jun 2003 22:48:33 +0100
dave.bentham@ntlworld.com wrote:

> Hello
> 
> I upgraded my kernel on a Mandrake 9.0 base from 2.4.20 to the new
> 2.4.21 tonight - built from source patches as I always do; followed by
> reinstalling the NVidia drivers and ALSA.
> 
> But there seems to be a major failure when the computer just stops
> with no warning. Two scenarios that seem to repeat it include starting
> Loki's Heretic2 off, and mounting the CDRW drive via WindowMaker dock
> app. I cannot do anything when this happens; can't hotkey out of X,
> can't telnet to it from my other networked PC. I have to power down
> and back up.
> 
> It seems to be a few seconds after the trigger that the lock up
> occurs, and also it starts flashing the keyboard Caps Lock and Scroll
> Lock LEDs in step at about 1 Hz. I'm sure its trying to tell me
> something...
> 
> Thanks in advance
> 
> Dave
> 


-- 
A computer without Microsoft is like chocolate cake without mustard.

