Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270661AbRHNSYd>; Tue, 14 Aug 2001 14:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270652AbRHNSYY>; Tue, 14 Aug 2001 14:24:24 -0400
Received: from mail.webmaster.com ([216.152.64.131]:64915 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S270631AbRHNSYT>; Tue, 14 Aug 2001 14:24:19 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Helge Hafting" <helgehaf@idb.hist.no>, <linux-kernel@vger.kernel.org>
Subject: RE: Is there something that can be done against this ???
Date: Tue, 14 Aug 2001 10:10:24 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMMEPDDCAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3B791CA8.29E97814@idb.hist.no>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> David Schwartz wrote:

> > > The question is not : "is this script dangerous ?",
> > > but "are you ready to blindly execute a shell script
> > > (or any program) that you receive in your  mail ?".

> >         Sure, as a user created solely for that purpose, it
> > should be entirely
> > safe.

> It definitely ought to be safe.  But don't run any script people mail
> you in a test account - you'll be sorry when they exploit a bug in
> your kernel or perhaps one of your trusted daemons...

	Well that's my point. If you don't feel comfortable doing this, it's
because you suspect that something is wrong with your system's security. Of
course, we don't go testing how scratch-resistant our glasses are by
attempting to scratch them. In principle, however, it should be safe from an
OS standpoint assuming your system has been configured to be secure.

	DS

