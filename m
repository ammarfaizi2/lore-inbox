Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270003AbUJSV7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270003AbUJSV7j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 17:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269993AbUJSV6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:58:47 -0400
Received: from gprs214-24.eurotel.cz ([160.218.214.24]:7552 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269788AbUJSVyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 17:54:17 -0400
Date: Tue, 19 Oct 2004 23:54:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       penguinppc-team@lists.penguinppc.org
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041019215401.GG1142@elf.ucw.cz>
References: <416E6ADC.3007.294DF20D@localhost> <87d5zkqj8h.fsf@bytesex.org> <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be> <1097844301.9863.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1097844301.9863.11.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Pá 15-10-04 13:45:10, Alan Cox wrote:
> On Gwe, 2004-10-15 at 13:38, Geert Uytterhoeven wrote:
     ~~~-
	  eh? :-)

> > Why not? Of course you won't get any output before the graphics card has been
> > re-initialized to a sane and usable state...
> 
> That will depend on the system. The AMD64 boxes I have all allow the
> bios to post the video card on S3 resume. 

Do you have Arima a.k.a. eMachines notebook near you? That's the one I
can't get to work...

> For a lot of other stuff we can run the bios directly on the resume path
> without emulation (or for intel call the video restore bios
> int). For the rest this could be a useful weapon.

What's the video restore bios int?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
