Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbTI3OQz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 10:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbTI3OQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 10:16:55 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:62938 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261514AbTI3OQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 10:16:54 -0400
Date: Tue, 30 Sep 2003 16:16:51 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: keyboard repeat / sound [was Re: Linux 2.6.0-test6]
Message-ID: <20030930141651.GB25492@ucw.cz>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <20030928085902.GA3742@k3.hellgate.ch> <20030929151643.GA15992@ucw.cz> <20030930075024.GA1620@squish.home.loc> <20030930125126.GA24122@ucw.cz> <20030930132134.GA17242@cathedrallabs.org> <20030930134453.GA25198@ucw.cz> <20030930140521.GB17242@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930140521.GB17242@cathedrallabs.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 11:05:21AM -0300, Aristeu Sergio Rozanski Filho wrote:

> > What problem exactly was that?

> it repeats pressed keys too fast. sometimes it's even impossible to
> type something without get repeated letters.
> iirc, you wrote a mail days ago about how to help to debug
> this. i may dig it and provide some extra information if you want.

Ahh, I think I remember. Well, you can still try with atkbd_softrepeat=1
to see if the too fast autorepeat still happens if software autorepeat
is used. It doesn't work with test6, but test7 will hopefully include a
fix.

> > 	http://w1.894.telia.com/~u89404340/touchpad/index.html
> > 
> > XFree86 driver?
> i didn't, i'll check this, thanks
> 
> -- 
> aris
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
