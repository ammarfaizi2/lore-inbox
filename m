Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267923AbTAHUex>; Wed, 8 Jan 2003 15:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267924AbTAHUex>; Wed, 8 Jan 2003 15:34:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58379 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267923AbTAHUew>; Wed, 8 Jan 2003 15:34:52 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH][TRIVIAL] menuconfig color sanityExpires:
Date: 8 Jan 2003 12:43:30 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <avi2hi$136$1@cesium.transmeta.com>
References: <20030108104714.GM268@gage.org> <Pine.LNX.3.96.1030108095857.21895A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.96.1030108095857.21895A-100000@gatekeeper.tmr.com>
By author:    Bill Davidsen <davidsen@tmr.com>
In newsgroup: linux.dev.kernel
> 
> Man, did you look at this on a console? That is uglier than a hedgehog's
> asshole! Good idea, poor implementation. Please retry, the default colors
> are not as bad on an xterm as the new colors on a console. And with small
> memory machines I sure don't build kernels using X! 
> 

Also, whatever color set is chosen: make sure it works on a
512-character font console, which doesn't have the high-intensity
colors.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
