Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265256AbUD3UN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUD3UN4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 16:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265262AbUD3UN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 16:13:56 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:31885 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265256AbUD3UNg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:13:36 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Timothy Miller <miller@techsource.com>, hzhong@cisco.com
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Fri, 30 Apr 2004 22:14:35 +0200
User-Agent: KMail/1.5.3
Cc: "'Peter Williams'" <peterw@aurema.com>,
       "'Marc Boucher'" <marc@linuxant.com>,
       "'Sean Estabrooks'" <seanlkml@rogers.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Paul Wagland'" <paul@wagland.net>, "'Rik van Riel'" <riel@redhat.com>,
       koke@sindominio.net, "'Rusty Russell'" <rusty@rustcorp.com.au>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'David Gibson'" <david@gibson.dropbear.id.au>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com> <40929F5B.9090603@techsource.com>
In-Reply-To: <40929F5B.9090603@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404302214.35497.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 of April 2004 20:47, Timothy Miller wrote:
> Hua Zhong wrote:
> > Linuxant did a wrong thing by working around the warning message, but I
> > don't think it's fair to accuse of their business because they allow
> > binary drivers run on Linux.

IMHO open-source drivers are one of the biggest advantages of Linux.

Linuxant seems to be using double standards: we are all for open-source OS but
_our_ drivers have to remain proprietary (I don't care about reasons here).

Marc, I _appreciate_ all your hard-work on open-source projects and I can
understand reasons why Linuxant makes it's drivers but please, be honest. :)
I think that you agree that things like HSF drivers or DriverLoader
(because they are workarounds not the real solution) _may_ slow down creation
of real open-source drivers.

I also hope that this '\0' issue won't scare you from working with
community in the future.

Regards,
Bartlomiej

