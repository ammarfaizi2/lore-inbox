Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbTLKILr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 03:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbTLKILr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 03:11:47 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:54351 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S264376AbTLKILq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 03:11:46 -0500
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: <rob@landley.net>, "'Larry McVoy'" <lm@bitmover.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>
Cc: "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, <Valdis.Kletnieks@vt.edu>,
       "'Kendall Bennett'" <KendallB@scitechsoft.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Linux GPL and binary module exception clause?
Date: Thu, 11 Dec 2003 00:11:40 -0800
Organization: Cisco Systems
Message-ID: <014301c3bfbe$67fa1540$d43147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <200312110143.23422.rob@landley.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For one thing, the plugin was made by someone without access 
> to Netscape or IE's source code, using a documented interface 
> that contained sufficient information to do the job without access 
> to that source code.
>
> Yes, it matters.

_What_ matters?

Open source? (if you write a plugin for an opensource
kernel/application, you are not plugin anymore and you are derived
work.) I am sure you don't mean it.

Documented interface? Hey, there are sources which are the best
documentation. :-)

Seriously, even if I accept that there is never an intent to support a
stable ABI for kernel modules, some vendor can easily claim that "we
support a stable ABI, so write kernel modules for the kernel we
distribute".

Anything can prevent that? I cannot see GPL disallow it.

So OK, Linus and other kernel developers never intended to provide a
stable ABI, but someone else could. The original author's intent is
never relevant anymore. This is the goodness of opensource, isn't it?

