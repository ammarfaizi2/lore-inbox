Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263449AbTH0PUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbTH0PUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:20:54 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:45536 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263449AbTH0PUw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:20:52 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Promise IDE patches
Date: Wed, 27 Aug 2003 17:21:31 +0200
User-Agent: KMail/1.5
Cc: Jan Niehusmann <jan@gondor.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030826223158.GA25047@gondor.com> <200308270054.27375.bzolnier@elka.pw.edu.pl> <1061996314.22739.36.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1061996314.22739.36.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308271721.31751.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 of August 2003 16:58, Alan Cox wrote:
> On Maw, 2003-08-26 at 23:54, Bartlomiej Zolnierkiewicz wrote:
> > Thanks Jan.
> >
> > Marcelo can you apply these patches?
>
> The last one looks wrong to me. At the least it needs to check
> which pdc202xx chip first

Yep, you are right.
[ I guess that PIO forced is 20246 specific, but we don't know. ]

--bartlomiej

