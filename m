Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261716AbSI0Oq6>; Fri, 27 Sep 2002 10:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261717AbSI0Oq6>; Fri, 27 Sep 2002 10:46:58 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:19138 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S261716AbSI0Oq5>;
	Fri, 27 Sep 2002 10:46:57 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200209271451.SAA21049@sex.inr.ac.ru>
Subject: Re: Problems with tcp_retransmit_skb - Please omit the previous incomplete mail
To: rpranesh@yahoo.com (Venkatesh Rao)
Date: Fri, 27 Sep 2002 18:51:57 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020927144332.74044.qmail@web21406.mail.yahoo.com> from "Venkatesh Rao" at Sep 27, 2 07:43:32 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> This is the only socket which *sends* relatively huge

... loses enough of date to overflow, all the rest leak a bit and
silently, until all the memory exhausts and machine dies. :-)


> Can this still be a network driver problem?

No doubts, it is.

Alexey
