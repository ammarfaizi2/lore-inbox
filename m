Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbUACNsS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 08:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbUACNsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 08:48:18 -0500
Received: from ns.unixsol.org ([193.110.159.2]:19463 "HELO ns.unixsol.org")
	by vger.kernel.org with SMTP id S263491AbUACNsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 08:48:17 -0500
Message-ID: <3FF6C81A.4060408@unixsol.org>
Date: Sat, 03 Jan 2004 15:48:10 +0200
From: Georgi Chorbadzhiyski <gf@unixsol.org>
Organization: Unix Solutions (http://unixsol.org)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030617
X-Accept-Language: en-us, en, bg
MIME-Version: 1.0
To: Jens Benecke <jens-usenet@spamfreemail.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mjb2 useage report (K7-2400/1G/IDE/ASUS-nForce2)
References: <3554040.5Ujn9dJA3e@spamfreemail.de>
In-Reply-To: <3554040.5Ujn9dJA3e@spamfreemail.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Benecke wrote:
> this is a simple user's report on switching to 2.6.0 from 2.4.22.
> 
> so far, 2.6.0 hasn't made things worse here. I can use my scanner (epson
> USB), I can use mouse (USB) XFree86 4.3 and NVIDIA driver (with the patches
> from minion.de). I can use MPlayer to play movie files and listen to music
> with the new ALSA drivers (I used ALSA before though).
> 
> Good work!
> 2.4.1 (the first 2.4 I used) was much worse. Not to speak of the later 2.4
> kernel versions ... ;)
> 
> I don't notice any real preformance improvement over 2.4.2x, though.
> 
> Most everything works, although there are a few tidbits:
> 
> 
> - LOCAL_APIC and PNPBIOS made my laptop crash before it could even write any
> boot messages on the screen. (I posted about this earlier).
> 
> - Not putting the X server to -10 nice level (as told in the 2.6 HOWTO I dug
> up somewhere, that also mentioned module-init-tools etc) makes my mouse
> jitter whenever a process eats 100% CPU. That is not nice. XMMS also skips
> a second then.
> The X server also freezes for a seond from time to time for no apparent
> reason (other than the CPU useage going up). I have Folding@Home clients
> running on this machine (nice=19) and usually don't notice them at all
> though.
> 
> 
> - Inserting my external IDE->USB/Firewire harddisk into the internal USB
> slot (nForce2 mainboard) made Linux go into an endless loop:

Could this be the same kind of problem ?

http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg15962.html

-- 
Georgi Chorbadzhiyski
http://georgi.unixsol.org/

