Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270258AbRHHBU1>; Tue, 7 Aug 2001 21:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270259AbRHHBUS>; Tue, 7 Aug 2001 21:20:18 -0400
Received: from spiral.extreme.ro ([212.93.159.205]:63620 "HELO
	spiral.extreme.ro") by vger.kernel.org with SMTP id <S270258AbRHHBUC>;
	Tue, 7 Aug 2001 21:20:02 -0400
Date: Wed, 8 Aug 2001 04:21:44 +0300 (EEST)
From: Dan Podeanu <pdan@spiral.extreme.ro>
To: J Sloan <jjs@toyota.com>
cc: Noel Koethe <noel@koethe.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x IP aliase max eth0:16 (16 aliases), where to change?
In-Reply-To: <3B70764D.E90F96B6@lexus.com>
Message-ID: <Pine.LNX.4.33L2.0108080418290.24309-100000@spiral.extreme.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The maximum aliases I can configure with a 2.4.x kernel is 16, right?
>
> er... I would expect you could do thousands....

Where did you come up with that '16' actually? Why not 3? 17? 100?

Right now I'm running with 2.4.6-ac5, eth0 and 20 aliases for it
(eth0:1..eth0:20). As expected, it didn't complain nor did anything
different for 17th, as opposed to 16th interface. Perhaps you're running
some old net tools/ifconfig, if you tested at all that is.

I have:
net-tools 1.59
ifconfig 1.40 (2000-05-21)

Cheers, Dan.


