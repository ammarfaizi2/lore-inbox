Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbRDCMAu>; Tue, 3 Apr 2001 08:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131564AbRDCMAl>; Tue, 3 Apr 2001 08:00:41 -0400
Received: from k213a.lanhovi.ton.tut.fi ([193.166.80.217]:3726 "HELO
	k213a.lanhovi.ton.tut.fi") by vger.kernel.org with SMTP
	id <S131158AbRDCMAb>; Tue, 3 Apr 2001 08:00:31 -0400
Date: Tue, 3 Apr 2001 14:59:44 +0300 (EEST)
From: Sami Nieminen <samppa@k213a.lanhovi.ton.tut.fi>
To: <linux-kernel@vger.kernel.org>
Cc: <robert.holmberg@helsinki.fi>
Subject: Re: BTTV problems in 2.4.3
Message-ID: <Pine.LNX.4.30.0104031453450.374-100000@butthead.ton.tut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm having some bttv problems in 2.4.3 (2.4.2 works fine). When my xawtv
> window (or my fbtv resolution) gets to a certain point (like 768x576,
> which is what I want, 640x480 is still fine) the right part of the tv
> window is left black. I'm back to using 2.4.2 again, but I could produce a
> screenshot if you want me to. We're not talking some small bar being left
> black, but rather a small bar on the left showing 20-25% of the tv picture.

I have the same problem with 2.4.2-ac20 when using xawtv's overlay mode.
When using grabdisplay mode the picture is fine. Also overlay looks good
if I keep the window size small enough.

Sami

-- 
Whoa...I did a 'zcat /vmlinuz > /dev/audio' and I think I heard God...

