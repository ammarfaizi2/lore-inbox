Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUGYK4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUGYK4j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 06:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUGYK4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 06:56:39 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:54022 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S263100AbUGYK4i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 06:56:38 -0400
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: Re: 3C905 and ethtool
Date: Sun, 25 Jul 2004 12:56:34 +0200
User-Agent: KMail/1.6.2
References: <200407251016.22001.cijoml@volny.cz> <20040725102700.GN18676@lug-owl.de>
In-Reply-To: <20040725102700.GN18676@lug-owl.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407251256.34500.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How magical words :)
Feel free to patch my source :D

But problem is, that I have these nic in only production servers and haven't 
one in testing computer :(

M.

Dne ne 25. èervence 2004 12:27 Jan-Benedict Glaw napsal(a):
> On Sun, 2004-07-25 10:16:21 +0200, Bc. Michal Semler <cijoml@volny.cz>
>
> wrote in message <200407251016.22001.cijoml@volny.cz>:
> > I wanted to get info about my NIC via ethtool, but it writes:
> > # ethtool eth0
> > Cannot get device settings: Operation not supported
> > # ethtool eth1
> > Cannot get device settings: Operation not supported
> >
> > 00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
> > (rev 30) 01:08.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX
> > [Boomerang]
> >
> > Any possibility to add this support into this driver?
>
> Feel free to do it:)  Some other cards support it, so their code should
> give you an idea about how that is done...
>
> MfG, JBG
