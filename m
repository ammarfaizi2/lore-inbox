Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbUAZQ00 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 11:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264433AbUAZQ0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 11:26:25 -0500
Received: from mail.broadpark.no ([217.13.4.2]:47256 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S264411AbUAZQ0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 11:26:24 -0500
Message-ID: <002e01c3e429$2346cb20$1e00000a@black>
Reply-To: "Daniel Andersen" <daniel@majorstua.net>
From: "Daniel Andersen" <kernel-list@majorstua.net>
To: "Harald Dunkel" <harald.dunkel@t-online.de>
Cc: <linux-kernel@vger.kernel.org>
References: <401538AB.8090106@t-online.de>
Subject: Re: 2.6.1: Alsa 0.9.7?
Date: Mon, 26 Jan 2004 17:26:22 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi folks,
> 
> CONFIG_SND_VERSION says that Alsa in 2.6.1 is version
> 0.9.7. Is this correct?
> 
> I'm just curious.
> 
> 
> Regards
> 
> Harri

That is correct.

Please look at linux/include/sound/version.h in the kernel-source.

Daniel Andersen
