Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVA2TKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVA2TKw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVA2TKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:10:01 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:64206 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261540AbVA2TIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:08:14 -0500
Date: Fri, 28 Jan 2005 20:27:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Wiktor <victorjan@poczta.onet.pl>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: AT keyboard dead on 2.6
Message-ID: <20050128192732.GA2799@ucw.cz>
References: <41F11F79.3070509@poczta.onet.pl> <d120d500050121074831087013@mail.gmail.com> <41F15307.4030009@poczta.onet.pl> <d120d500050121113867c82596@mail.gmail.com> <41F69FFE.2050808@poczta.onet.pl> <20050128143121.GB12137@ucw.cz> <d120d50005012806467cc5ee03@mail.gmail.com> <41FA90F8.6060302@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FA90F8.6060302@poczta.onet.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 08:22:32PM +0100, Wiktor wrote:
> Hi,
> 
> >This dmesg looks like the keyboard works perfectly OK. Do new lines
> >appear in dmesg when you press keys while the system is running?
> 
> eeeeeeee.....no? no, they don't. i've new dmesg for you - it reports 
> timeouts while trying to perform keyboard reset (by atkbd.reset=1). 
> after detection pressing any keys has absolutley no effect. maybe it's 
> some timeout-violation?

It still looks OK. It seems to be a very ancient keyboard. Can you try with
a newer one? That'd tell us whether it's the controller or the keyboard
that is giving problems.

What keyboard model is it? What machine?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
