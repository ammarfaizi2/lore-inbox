Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSGAP6L>; Mon, 1 Jul 2002 11:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315708AbSGAP6K>; Mon, 1 Jul 2002 11:58:10 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53263 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315634AbSGAP6J>; Mon, 1 Jul 2002 11:58:09 -0400
Date: Mon, 1 Jul 2002 11:55:10 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
cc: vda@port.imtp.ilyichevsk.odessa.ua, Willy TARREAU <willy@w.ods.org>,
       willy@meta-x.org, linux-kernel@vger.kernel.org,
       Ronald.Wahl@informatik.tu-chemnitz.de
Subject: Re: [ANNOUNCE] CMOV emulation for 2.4.19-rc1
In-Reply-To: <20020701130327.38962.qmail@web20506.mail.yahoo.com>
Message-ID: <Pine.LNX.3.96.1020701115336.23428B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2002, [iso-8859-1] willy tarreau wrote:

> Like I said above, I didn't insist on optimizations,
> I prefered to get a clear code first. If I want to
> optimize, I think most of this will be assembler.

This sounds good, the idea is that it should work at all, clarity is good,
I can't imagine anyone running this long term instead of building a
compile with the right machine type.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

