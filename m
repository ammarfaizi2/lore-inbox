Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284902AbRLURTv>; Fri, 21 Dec 2001 12:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284890AbRLURTd>; Fri, 21 Dec 2001 12:19:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28179 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284850AbRLURTP>; Fri, 21 Dec 2001 12:19:15 -0500
Subject: Re: aio
To: davem@redhat.com (David S. Miller)
Date: Fri, 21 Dec 2001 17:28:36 +0000 (GMT)
Cc: billh@tierra.ucsd.edu, bcrl@redhat.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
In-Reply-To: <20011219.172046.08320763.davem@redhat.com> from "David S. Miller" at Dec 19, 2001 05:20:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16HTTI-0000w0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Precisely, in fact.  Anyone who can say that Java is going to be
> relevant in a few years time, with a straight face, is only kidding
> themselves.

Oh it'll be very relevant. Its leaking into all sorts of embedded uses, from
Digital TV to smartcards. Its still useless for serious high end work an
likely to stay so.

> Java is not something to justify a new kernel feature, that is for
> certain.

There we agree. Things like the current asynch/thread mess in java are
partly poor design of language and greatly stupid design of JVM.
