Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135989AbREGEGH>; Mon, 7 May 2001 00:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135990AbREGEF6>; Mon, 7 May 2001 00:05:58 -0400
Received: from mail11.jump.net ([206.196.91.11]:61180 "EHLO mail11.jump.net")
	by vger.kernel.org with ESMTP id <S135989AbREGEFt>;
	Mon, 7 May 2001 00:05:49 -0400
Message-ID: <3AF61F87.536AC034@sgi.com>
Date: Sun, 06 May 2001 23:07:35 -0500
From: Eric Sandeen <sandeen@sgi.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-SGI_XFS_1.0smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: afu@fugmann.dhs.org
Subject: Re: CANBus driver.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders - 

There is a bunch of code for Linux CANbus/DeviceNet drivers for SST
cards (sstech.on.ca) here:

http://home.att.net/~marksu/dn5136man.html

"This is a Linux driver and library of useful functions and utility
applications for the SST 5136-DN family of CAN bus/DeviceNet interface
boards."

SST makes these cards in various formats, pcmcia, PC104, isa...

Also found something here, not familiar with it though:

http://www.synergetic.com/linux/

Good luck,

-Eric

Anders Peter Fugmann wrote:

> Some of my fellow students and I, have started a project in which we 
> have to implement a linux driver for a CANbus ISA card ( AROS: A-858D 
> PCCAN -x ver. 1.12). 
> 
> Does there exist any work on a CANBus driver for linux already? 

-- 
Eric Sandeen      XFS for Linux     http://oss.sgi.com/projects/xfs
sandeen@sgi.com   SGI, Inc.
