Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272855AbRIPVyQ>; Sun, 16 Sep 2001 17:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272851AbRIPVyH>; Sun, 16 Sep 2001 17:54:07 -0400
Received: from arioch.oche.de ([194.94.252.126]:56335 "HELO arioch.oche.de")
	by vger.kernel.org with SMTP id <S272843AbRIPVxx>;
	Sun, 16 Sep 2001 17:53:53 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
In-Reply-To: <Pine.GSO.4.21.0109140523060.3130-100000@jacui>
Mail-Copies-To: never
From: Carsten Leonhardt <leo@arioch.oche.de>
Date: 16 Sep 2001 23:53:34 +0200
In-Reply-To: <Pine.GSO.4.21.0109140523060.3130-100000@jacui>
Message-ID: <87wv2yvm3l.fsf@cymoril.oche.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Copyleft)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Jung Drebes <drebes@inf.ufrgs.br> writes:

> I tested here and it seems that bit 7 is responsible. Here is the
> diff to pci-pc.c:

I tried it here on my Tyan Trinity KT-A (S2390B), and it works!

Very nice!

Thanks,
  leo
