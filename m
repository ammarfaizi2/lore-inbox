Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272844AbTHKUNx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 16:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272910AbTHKUNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 16:13:53 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:55512 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S272844AbTHKUNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 16:13:50 -0400
Date: Mon, 11 Aug 2003 22:13:48 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Valdis.Kletnieks@vt.edu
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030811201348.GA9561@ucw.cz>
References: <1060616931.8472.22.camel@defiant.flameeyes> <20030811163913.GA16568@bytesex.org> <20030811175642.GC2053@convergence.de> <20030811185947.GA8549@ucw.cz> <20030811191709.GN2627@elf.ucw.cz> <20030811193401.GA8957@ucw.cz> <200308111959.h7BJxT0r030229@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308111959.h7BJxT0r030229@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 03:59:29PM -0400, Valdis.Kletnieks@vt.edu wrote:

> On Mon, 11 Aug 2003 21:34:01 +0200, Vojtech Pavlik said:
> > On Mon, Aug 11, 2003 at 09:17:10PM +0200, Pavel Machek wrote:
> > > Ahha, I thought BTN_1 would be first mouse button ;-). Will fix that.
> > No, that'd be BTN_LEFT.
> 
> Urp.  My mouse has 7 buttons (ok, 5, one of which is a scrollwheel and
> generates 3 different events).  Which left button do you mean? ;)

For mouse, there is BTN_LEFT, BTN_RIGHT, BTN_MIDDLE (the three original
buttons) and BTN_SIDE and BTN_EXTRA for two more (your five). Then there
is REL_WHEEL and REL_HWHEEL for two scrollwheels on it. Satisfied?

> http://www.microsoft.com/catalog/display.asp?subid=22&site=10561
> Fortunately for the coders, it doesn't come in a wireless version yet. ;)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
