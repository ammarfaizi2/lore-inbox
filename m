Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264542AbRFTSRe>; Wed, 20 Jun 2001 14:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264546AbRFTSRY>; Wed, 20 Jun 2001 14:17:24 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:61193 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S264542AbRFTSRQ>;
	Wed, 20 Jun 2001 14:17:16 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200106201816.WAA19499@ms2.inr.ac.ru>
Subject: Re: softirq in pre3 and all linux ports
To: paulus@samba.org
Date: Wed, 20 Jun 2001 22:16:46 +0400 (MSK DST)
Cc: andrea@suse.de, torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <15152.6527.366544.713462@cargo.ozlabs.ibm.com> from "Paul Mackerras" at Jun 20, 1 01:33:19 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Soft irqs should definitely not be much heavier than an irq handler,
> if they are then we have implemented them wrongly somehow.

For example, all the networking nicely fits to this class. :-)

Alexey
