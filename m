Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130186AbRCLTlN>; Mon, 12 Mar 2001 14:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbRCLTlD>; Mon, 12 Mar 2001 14:41:03 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:55314 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130187AbRCLTkz>;
	Mon, 12 Mar 2001 14:40:55 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200103121940.WAA10783@ms2.inr.ac.ru>
Subject: Re: Feedback for fastselect and one-copy-pipe
To: manfred@colorfullife.com (Manfred Spraul)
Date: Mon, 12 Mar 2001 22:40:19 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001601c0ab24$37a50d70$5517fea9@local> from "Manfred Spraul" at Mar 12, 1 07:42:18 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> It returns immediately on all unix platforms I tested

I see. It is essential moment. PAGE_SIZE was really bad threshold value.
Sigh and alas.

Alexey


PS BTW "all unix" is unlikely to include freebsd. 8)
