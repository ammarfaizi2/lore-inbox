Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265191AbTLKSW6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 13:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbTLKSW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 13:22:58 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:40277 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S265191AbTLKSW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 13:22:57 -0500
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: <rob@landley.net>, "'Larry McVoy'" <lm@bitmover.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>
Cc: "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, <Valdis.Kletnieks@vt.edu>,
       "'Kendall Bennett'" <KendallB@scitechsoft.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Linux GPL and binary module exception clause?
Date: Thu, 11 Dec 2003 10:22:51 -0800
Organization: Cisco Systems
Message-ID: <016a01c3c013$c9aaa020$d43147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <200312110237.42998.rob@landley.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you write software by referring to documentation, the 
> barrier for it being a derivative work is higher than if you 
> write it by looking at another implementation.
> 
> [and the IBM/Compaq lawsuit]

What you mentioned is not relevant to the discussion, I think.

People who write kernel modules might read kernel sources, yes. But they
read kernel source to understand how it works, not to clone it. Even
user space programmers do that. Even people not writing software for
Linux do that. Isn't the open source spirit to encourage people to read
it? Now what you said indicates "read me, but you are then tainted and
when I sue you you have to provide evidence you are not".

People also reverse-engineer how closed-source software works. That is
how we got FAT/NTFS support in Linux. People also write various
interesting software using undocumented APIs of DOS and Windows.
Remember TSR? Remember <<Undocumented DOS/Windows>>?

We want the same thing on Linux. Great Linux is open source so we don't
have to do the same reverse-engineering thing as we did to M$ operating
systems (IOW, reading source is the easiest way to "reverse-engineer" so
we could write software that interfaces with the system). Now after
reading your comment, I have to wonder "which one is nicer, Linux or
Windows"?

Hua

