Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287991AbSABX65>; Wed, 2 Jan 2002 18:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287169AbSABX6D>; Wed, 2 Jan 2002 18:58:03 -0500
Received: from ns.sysgo.de ([213.68.67.98]:15356 "EHLO dagobert.svc.sysgo.de")
	by vger.kernel.org with ESMTP id <S288000AbSABX5Y>;
	Wed, 2 Jan 2002 18:57:24 -0500
Date: Thu, 3 Jan 2002 00:56:37 +0100 (MET)
From: Robert Kaiser <rob@sysgo.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "H. Peter Anvin" <hpa@zytor.com>, Dave Jones <davej@suse.de>,
        Robert Schwebel <robert@schwebel.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        Jason Sodergren <jason@mugwump.taiga.com>,
        Anders Larsen <anders@alarsen.net>, rkaiser@sysgo.de
Subject: Re: [PATCH][RFC] AMD Elan patch
In-Reply-To: <E16LuX4-0005wH-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0201030048290.8191-100000@dagobert.svc.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Jan 2002, Alan Cox wrote:

> The 400/410 this isnt a problem for. Its discontinued and the 5x0 detect
> differently (and actually have working serial ports I believe). 
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This part is not true AFAIK. I understand they "ported" that
incompatibility from the 4x0 to the 520.

> So its an end of life core

Yes, but is that an excuse for Linux to not support it ? I mean,
Linux still does support the 386 ...

Rob

----------------------------------------------------------------
Robert Kaiser                          email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14
D-55270 Klein-Winternheim / Germany    fax:   (49) 6136 9948-10


