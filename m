Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWEBUgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWEBUgz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWEBUgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:36:55 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:24844 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S932162AbWEBUgy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:36:54 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: C++ pushback
Date: Tue, 2 May 2006 13:36:45 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEELMLKAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <44514BC6.6020603@tmr.com>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Tue, 02 May 2006 13:32:39 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Tue, 02 May 2006 13:32:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> C++ allows more abstraction than C, unfortunately too many people go
> right past past abstraction to obfuscation. With operator overloading
> it's possible to generate write-only code, and programs where "A=B+C"
> does file operations :-( That doesn't belong in an operating system, C
> is the right choice.

>     -bill davidsen (davidsen@tmr.com)

	I reject any argument of the type "because a language *allows* you to do X,
and X is not always good, the language is bad". Now, if the language
*required* you to do bad things, that would be a different story.

	If I could demonstrate ways to do bad things in C that don't belong in an
operating system, would that convince you that C is not the right choice?
For example, C allows easy use of floating point math, which doesn't belong
in an operating system either.

	DS


