Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267076AbRGYSzA>; Wed, 25 Jul 2001 14:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267215AbRGYSyu>; Wed, 25 Jul 2001 14:54:50 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:64522 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S267076AbRGYSyj>;
	Wed, 25 Jul 2001 14:54:39 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107251854.WAA10018@ms2.inr.ac.ru>
Subject: Re: Patch suggestion for proxy arp on shaper interface
To: berto@fatamorgana.com (Roberto Arcomano)
Date: Wed, 25 Jul 2001 22:54:16 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01072520050001.01036@berto.casa.it> from "Roberto Arcomano" at Jul 25, 1 08:05:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> As I said in my first message, I tested it with 2.4.6 and it "appears" (I 
> tested it in a very little net) to work well

The patch works right, I think. But it is so utterly ugly and its scope
is so narrow, that I do think this is acceptable.

Actually, you may use CBQ instead it does not create problems of this
kind. Seems, scripts to setup it can be found in LRP. I can send it,
but I am not sure that my copy is the newest.

Alexey
