Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbTKHKcX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 05:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTKHKcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 05:32:23 -0500
Received: from cap175-219-202.pixi.net ([207.175.219.202]:2457 "EHLO
	beaucox.com") by vger.kernel.org with ESMTP id S261685AbTKHKcW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 05:32:22 -0500
From: "Beau E. Cox" <beau@beaucox.com>
Organization: BeauCox.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: PROBLEM: 2.4.23-pre7,pre8,pre9 hang on starting squid
Date: Sat, 8 Nov 2003 00:31:28 -1000
User-Agent: KMail/1.5.4
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0311061204510.8534-100000@logos.cnet> <200311070600.02069.beau@beaucox.com> <20031107155147.05671d94.rddunlap@osdl.org>
In-Reply-To: <20031107155147.05671d94.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311080031.28457.beau@beaucox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 November 2003 01:51 pm, Randy.Dunlap wrote:
> On Fri, 7 Nov 2003 06:00:01 -1000 "Beau E. Cox" <beau@beaucox.com> wrote:
> | On Thursday 06 November 2003 04:06 am, Marcelo Tosatti wrote:
> | > On Mon, 3 Nov 2003, Beau E. Cox wrote:
> | > > [1.] summary:
> | > >
> | > > 2.4.23-pre7,pre8,pre9 hang depending on when 'squid' is started.
> | > >
> | > > [snipped]
> | >
> | > Strange.
> | >
> | > Can you find out in which -pre the problem starts?
> |
> | Hi - I want to track down the 'pre' where my problem started (I would
> | need 2.4.23-pre1 thru pre6), but I can't find them anywhere on the
> | kernel archaive site (mirros too). Where can I get these pre patches?
>
> They are in this directory:
>   http://www.kernel.org/pub/linux/kernel/v2.4/testing/
>
> --
> ~Randy
> MOTD:  Always include version info.

Thanks Randy -

I don't know how I missed them...
I'll start from pre1 and test. This will take several days to a week.

Aloha => Beau;

