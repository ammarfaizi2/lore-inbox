Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316996AbSGCLHm>; Wed, 3 Jul 2002 07:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316997AbSGCLHl>; Wed, 3 Jul 2002 07:07:41 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:25503 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S316996AbSGCLHl>; Wed, 3 Jul 2002 07:07:41 -0400
Date: Wed, 3 Jul 2002 12:10:10 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Rob Landley <landley@trommello.org>
cc: Bill Davidsen <davidsen@tmr.com>, Adrian Bunk <bunk@fs.tum.de>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Kernel release management
In-Reply-To: <200207030718.g637I0L145202@pimout2-int.prodigy.net>
Message-ID: <Pine.LNX.4.44.0207031204000.3572-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Auth-User: mb
X-uvscan-result: clean (17Pi1S-0002TD-00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 2 Rob Landley wrote:

>People using the systems in production are going to care about stability.
>People selling systems to people using them in production are going to care
>about the stable series.  This means most of the people who have day jobs
>working with Linux at places like Red Hat and IBM.

So maybe look at it the other way around. You can start running Linux 2.6
on your Really Important Machines when Linux 2.7 forks. There'll be plenty
of version-number-junkies who will find the 2.6 bugs under common loads;
until the fork, 2.4 ought to be adequate. Except of course for your Scary
Desktop Machines, where you'll find the Mega Features (eg low-latency) a
bit harder to resist :)

Matt

