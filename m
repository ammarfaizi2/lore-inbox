Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbTBXN0r>; Mon, 24 Feb 2003 08:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbTBXN0r>; Mon, 24 Feb 2003 08:26:47 -0500
Received: from barclay.balt.net ([195.14.162.78]:7350 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id <S266996AbTBXN0q>;
	Mon, 24 Feb 2003 08:26:46 -0500
Date: Mon, 24 Feb 2003 15:35:58 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.62-mm3 - no X for me
Message-ID: <20030224133558.GA6690@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <20030223230023.365782f3.akpm@digeo.com> <3E5A0F8D.4010202@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E5A0F8D.4010202@aitel.hist.no>
User-Agent: Mutt/1.4i
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 01:26:53PM +0100, Helge Hafting wrote:
> 2.5.62-mm3 boots up fine, but won't run X.  Something goes
> wrong switching to graphics so my monitor says "no signal"
> 
> Using radeonfb:
> Switching to the framebuffer console almost works, but
> the video mode is messed up so parts of the text appear
> all over the screen.  Switching back to X again shows
> X in a very messed up video mode, some sort
> of resolution mismatch.
> 
> Using plain vga console:
> Nothing happens on the screen after I get "no signal",
> console switching has no effect.  Sync&Reboot via
> sysrq works though.
> 
> The kernel uses UP, preempt, no module support, devfs configured
> but not used.
> 
> Hardware:
> 2.4GHz P4, 512M
> 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY
> 00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP

Same is here. Radeon too, only it is Radeon M7 LY 8)
> 
> Helge Hafting
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
