Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316330AbSEZTxZ>; Sun, 26 May 2002 15:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316334AbSEZTxZ>; Sun, 26 May 2002 15:53:25 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:34709 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S316330AbSEZTxY>;
	Sun, 26 May 2002 15:53:24 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200205261952.XAA25634@sex.inr.ac.ru>
Subject: Re: sk_buff modification problem -> (almost) solved
To: ww@kt.e-technik.uni-dortmund.DE (Wolfgang Wegner)
Date: Sun, 26 May 2002 23:52:12 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020526193529.A11200@bigmac.e-technik.uni-dortmund.de> from "Wolfgang Wegner" at May 26, 2 09:45:04 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> It turned out to be a problem with the pcmcia-cs-3.1.33 package i was using,
> now i modified the in-kernel orinoco driver to generate the timestamps i want,
> and everything works as expected.
> 
> What i do not understand is how such a behaviour can evolve, without any
> compiler warning?

But _what_ did you change to make this working? Does this not imply
the answer?

Anyway, it would be better if you showed relevant patches.

Alexey
