Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284687AbRLJXY1>; Mon, 10 Dec 2001 18:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284738AbRLJXYR>; Mon, 10 Dec 2001 18:24:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14863 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284687AbRLJXX7>; Mon, 10 Dec 2001 18:23:59 -0500
Subject: Re: Linux 2.4.17-pre8
To: oxymoron@waste.org (Oliver Xymoron)
Date: Mon, 10 Dec 2001 23:32:51 +0000 (GMT)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.40.0112101640000.10405-100000@waste.org> from "Oliver Xymoron" at Dec 10, 2001 04:50:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DZul-0003ug-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd like to suggest again having patches include change logs. The basic
> idea is for a patch to contain a file like patch.foo in the top-level that
> includes the changelog entry and the maintainer runs a release script that

personally I think Marcelo is doing the right thing, which is actually 
applying the needed patches rather than trying to do half of ISO9001 
to keep a few people happy.

> them. This would make it much easier for people to know the details of
> what got fixed without further burdening The Maintainer.

<arrogant mode>
	If you are qualified to hack on the affected code you are able
to understand the one liner change summary
</arrogant mode>
