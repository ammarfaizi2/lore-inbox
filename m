Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUA0HMe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 02:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUA0HMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 02:12:33 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:5760 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263475AbUA0HMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 02:12:31 -0500
Date: Tue, 27 Jan 2004 08:12:41 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: yoann <informatique-nospam@mistur.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: atkbd.c: Unknown key released
Message-ID: <20040127071241.GA473@ucw.cz>
References: <200401261834.54450@sandersweb.net> <20040127052507.GF18411@charite.de> <bv4vbb$ru3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bv4vbb$ru3$1@sea.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 07:09:56AM +0100, yoann wrote:

> >>I keep getting the following in my syslog whenever I startx:
> >
> >Which hardware?
> >
> >>Jan 26 13:43:56 debian kernel: atkbd.c: Unknown key released (translated 
> >>set 2, code 0x7a on isa0060/serio0).
> >>Jan 26 13:43:56 debian kernel: atkbd.c: This is an XFree86 bug. It 
> >>shouldn't access hardware directly.
> >>Jan 26 13:43:57 debian kernel: atkbd.c: Unknown key released (translated 
> >>set 2, code 0x7a on isa0060/serio0).
> >>Jan 26 13:43:57 debian kernel: atkbd.c: This is an XFree86 bug. It 
> >>shouldn't access hardware directly.
> >>
> >>I don't get the error with the 2.4.24 kernel.
> >
> >Same here.
> 
> same here with a 2.6.2-rc1-mm2
> Xfree86 Version: 4.2.1-15 (debian sid)

2.4 just keeps its mouth shut and doesn't complain.
Hopefully someone fixes X.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
