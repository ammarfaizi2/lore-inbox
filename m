Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSHMNgf>; Tue, 13 Aug 2002 09:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSHMNgf>; Tue, 13 Aug 2002 09:36:35 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:18321 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S315358AbSHMNge>;
	Tue, 13 Aug 2002 09:36:34 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200208131340.RAA20981@sex.inr.ac.ru>
Subject: Re: Linux TCP problem while talking to hostme.bkbits.net ?
To: mroos@cs.ut.ee (Meelis Roos)
Date: Tue, 13 Aug 2002 17:40:10 +0400 (MSD)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.43.0208131137110.14316-100000@romulus.cs.ut.ee> from "Meelis Roos" at Aug 13, 2 11:40:08 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Things got stranger. The symptoms started to appear

:-) Hey, if we are not going to finish in lunatic asylum we need to do
something constructive yet. Please, find the place where the packet is dropped.

I do not understand what happens at all. It is surely not a plain
packet corruption because tcpdump shows correct packet. Hmm... of course,
provided you make tcpdump on receiving host.


Alexey
