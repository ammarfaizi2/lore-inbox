Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317429AbSFHRji>; Sat, 8 Jun 2002 13:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317430AbSFHRjh>; Sat, 8 Jun 2002 13:39:37 -0400
Received: from gw.aba.krakow.pl ([217.96.88.193]:32439 "HELO two.aba.krakow.pl")
	by vger.kernel.org with SMTP id <S317429AbSFHRjh>;
	Sat, 8 Jun 2002 13:39:37 -0400
Date: Sat, 8 Jun 2002 19:39:31 +0200
From: =?iso-8859-2?Q?Pawe=B3?= Krawczyk <kravietz@aba.krakow.pl>
To: linux-kernel@vger.kernel.org
Subject: "cannot disable RNG"?
Message-ID: <20020608173931.GE24261@aba.krakow.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's the reason for such a message from Linux 2.4.18:

i810_rng: cannot disable RNG, aborting
i810_rng hardware driver 0.9.6 loaded

I tried to boot on several different mainboards, on some
I got message that the RNG has not been detected at all,
and that was right because of specific chipset parts missing.
But on boards I was told they have i810 RNG for sure I get
this message. Is there anything I should do to additionally
enable the RNG?

-- 
Pawe³ Krawczyk * http://echelon.pl/kravietz/
Krakow, Poland * http://ipsec.pl/
