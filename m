Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285570AbRLYQRJ>; Tue, 25 Dec 2001 11:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285584AbRLYQQ7>; Tue, 25 Dec 2001 11:16:59 -0500
Received: from colorfullife.com ([216.156.138.34]:33552 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S285570AbRLYQQv>;
	Tue, 25 Dec 2001 11:16:51 -0500
Message-ID: <002001c18d5f$98cb62c0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <klink@clouddancer.com (Colonel)>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re:
Date: Tue, 25 Dec 2001 17:17:01 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I went to build 2.4.17 on a dinky box (486, 16M RAM), the
> config option was missing.  The box is a wall mount and is not very
> capable of multiple kernel experimentation alas.  Can someone
> supply some background as to what has happened?

It seems that RTNETLINK is now unconditionally enabled, I don't know
why.

--
    Manfred



