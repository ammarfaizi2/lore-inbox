Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268974AbRHTTsl>; Mon, 20 Aug 2001 15:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268963AbRHTTsb>; Mon, 20 Aug 2001 15:48:31 -0400
Received: from mail.webmaster.com ([216.152.64.131]:33154 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S268968AbRHTTsZ>; Mon, 20 Aug 2001 15:48:25 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Alex Bligh - linux-kernel" <linux-kernel@alex.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entropy from net devices - keyboard & IDE just as 'bad' [was Re: [PATCH] let Net Devices feed Entropy, updated (1/2)]
Date: Mon, 20 Aug 2001 12:48:39 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMCEDNDFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <2246712912.998317539@[10.132.112.53]>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alex Bligh wrote:

> Many non-i386 platforms have more finely grained timers than 1 jiffie.
> The problem is the code doesn't use them. So my point is, it seems
> illogical to throw stones at (often) theoretical issues with Robert's
> patch, when people's energy would be better diverted to help fix up
> hole in the current implementation.

	I don't understand the connection. Either Robert's patch is good or it's
bad. If there are other problems, then we can address those too. But to say
that Robert's patch is bad because it doesn't fix the most important problem
that you can think of doesn't make any sense. Every problem should be fixed,
and if Robert has a patch to fix one of them, then that's one less.

	You can certainly advise people to work on the most serious problems. But
you most certainly can't say that someone shouldn't work on X because Y is
more important.

	DS

