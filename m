Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270447AbTG1SlP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 14:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270444AbTG1SlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 14:41:15 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:47118 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S270426AbTG1SlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 14:41:13 -0400
Message-ID: <00bd01c35539$f42491c0$cd01a8c0@llewella>
From: "Bas Bloemsaat" <bloemsaa@xs4all.nl>
To: "Carlos Velasco" <carlosev@newipnet.com>
Cc: <netdev@oss.sgi.com>, <linux-net@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
References: <20030727165831.05904792.davem@redhat.com> <200307280211590888.10957DD9@192.168.128.16> <20030727171403.6e5bcc58.davem@redhat.com> <200307280235210263.10AADFF8@192.168.128.16> <20030727173600.475d95fb.davem@redhat.com> <200307280253090799.10BB2DF0@192.168.128.16> <20030727175557.1d624b36.davem@redhat.com> <200307280323020667.10D68954@192.168.128.16> <20030727183547.784b6ab5.davem@redhat.com> <200307281243530385.12D80171@192.168.128.16> <20030728100959.A13335@ns1.theoesters.com>
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Date: Mon, 28 Jul 2003 20:56:28 +0200
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, Im sorry I started this. It was a genuine error on my side, to assume I stumbled on a bug, while it is in fact a hotly
debated 'feature'. I did google for it, but must have missed it, it would have saved my weekend. I didn't want to (re)start a
religious war.

Maybe we should let it rest for a bit, until we have something to discuss about. Right now, I've have the idea that people are
talking about slightly different things.

> What I think David fails to realize is that in the real world, people
> use the hidden patch on a regular basis.  It is the simplest way to
> achieve what we want to in a server farm consisting of hundreds of
> servers.  It also involves the least overhead.
Me myself. I've downloaded it, and use it now. It works fine for me and I don't see any problems. But I do not oversee the whole
picture, and I don't think anybody fully understands the other camp's objections.

David, I hope that you will explain your side of the story, or maybe point to a webpage where it is explained clearly. I still have
no idea as to what your objections are, other than that in the past, another choice was made to do things.

Regards,
Bas



