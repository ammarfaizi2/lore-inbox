Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131894AbRCVBou>; Wed, 21 Mar 2001 20:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131898AbRCVBol>; Wed, 21 Mar 2001 20:44:41 -0500
Received: from shell.ca.us.webchat.org ([216.152.64.152]:60071 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S131894AbRCVBoY>; Wed, 21 Mar 2001 20:44:24 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <kern@e-zebra.net>, <linux-kernel@vger.kernel.org>
Subject: RE: hostid derived from...
Date: Wed, 21 Mar 2001 17:43:42 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKCEGINPAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
In-Reply-To: <Pine.LNX.4.21.0103221210090.15305-100000@wolf.ezebra.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> how does linux provide the hostid string?
>
> on a sun box this is a guaranteed unique identifier, since AFAIK
> intel architecture does not have this unique identifier can
> two linux boxes end up with same hostid by chance?

	If a Linux box is properly administered, it's hostid should not be the same
as any other Linux box that is properly administered. Of course, Linux does
nothing to stop you from shooting yourself in the foot.

	DS

