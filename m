Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133014AbRDRE4x>; Wed, 18 Apr 2001 00:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133015AbRDRE4n>; Wed, 18 Apr 2001 00:56:43 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:22415 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S133014AbRDRE4f>; Wed, 18 Apr 2001 00:56:35 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Laurent Chavet" <lchavet@av.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Is there a way to turn file caching off ?
Date: Tue, 17 Apr 2001 21:56:29 -0700
Message-ID: <NCBBLIEPOCNJOAEKBEAKIEMCOGAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3ADC7144.36E715C5@av.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is there a way to turn file caching off, or at least limit its size ?
>
> Thanks,
>
> Laurent Chavet

	What benefit do you think you would get by limiting its size? All that
would do is ensure you hit the cache thrashing point sooner.

	DS

