Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277977AbRJIVLW>; Tue, 9 Oct 2001 17:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277978AbRJIVLM>; Tue, 9 Oct 2001 17:11:12 -0400
Received: from anime.net ([63.172.78.150]:38417 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S277977AbRJIVLC>;
	Tue, 9 Oct 2001 17:11:02 -0400
Date: Tue, 9 Oct 2001 14:11:07 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
cc: Marco Berizzi <pupilla@hotmail.com>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] again: Re: Athlon kernel crash (i686 works)
In-Reply-To: <140103605516.20011009134517@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.30.0110091409300.17086-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, VDA wrote:
> Anybody still insist that 'Athlon bug' patch is not to be
> included into mainstream kernel?
> If someone doesn't like it, feel free to make it a config
> option (enabled by default!) and submit an updated patch.
> My original patch against 2.4.9 is at the end.

It should perhaps go in alan's pre-kernels, but it needs wide testing.

Want should make sure it doesn't break systems which are otherwise fine
without it.

And we still don't have any explanation from VIA what this mysterious bit
is supposed to do.

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

