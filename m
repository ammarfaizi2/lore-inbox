Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292912AbSB0UOO>; Wed, 27 Feb 2002 15:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292922AbSB0UNn>; Wed, 27 Feb 2002 15:13:43 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:8196 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S292927AbSB0UNT>;
	Wed, 27 Feb 2002 15:13:19 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200202272012.XAA10411@ms2.inr.ac.ru>
Subject: Re: Fw: memory corruption in tcp bind hash buckets on SMP?
To: raghuangadi@yahoo.com (Raghu Angadi)
Date: Wed, 27 Feb 2002 23:12:53 +0300 (MSK)
Cc: davem@redhat.com, raghuangadi@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020227200521.60597.qmail@web12302.mail.yahoo.com> from "Raghu Angadi" at Feb 27, 2 12:05:21 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> inverted order of insertion into the lists in tw_hashdance() is probably
> cleaner fix than inverted order of removal.. 

Why are they not equivalent? Good question? :-)

Alexey
