Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279844AbRJ3EJ7>; Mon, 29 Oct 2001 23:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279850AbRJ3EJw>; Mon, 29 Oct 2001 23:09:52 -0500
Received: from [63.193.79.18] ([63.193.79.18]:37870 "HELO mwg.inxservices.lan")
	by vger.kernel.org with SMTP id <S279844AbRJ3EJj>;
	Mon, 29 Oct 2001 23:09:39 -0500
Date: Mon, 29 Oct 2001 20:09:47 -0800
From: George Garvey <tmwg-linuxknl@inxservices.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.13-ac4
Message-ID: <20011029200947.C14203@inxservices.com>
In-Reply-To: <20011028204003.A1640@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011028204003.A1640@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Sun, Oct 28, 2001 at 08:40:03PM +0000
Organization: inX Services, Los Angeles, CA, USA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Just recently installed a dlink dge550t in P3 Asus CUV4X-E. Still has
vortex board installed, but not connected to LAN. Connected to 10/100
switch still.
   After switching to 2.4.13-ac4, short time after boot start getting
transmit timeout. No log, because that goes to another system on LAN.
Will reproduce if exact message is desired.
   Rebooted 2.4.13-ac4. Got timeout again shortly after.
   Rebooted back to 2.4.12-ac3. No problems for rest of day. Running
RML's preempt patch on both kernels: that's the only difference from ac
(except for nVidia driver module).
   Willing to get better information if this is worth pursuing.
