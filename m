Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbVHMXIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbVHMXIG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 19:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbVHMXIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 19:08:05 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:57784 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S932397AbVHMXID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 19:08:03 -0400
Message-ID: <13573691.1123974481892.JavaMail.ngmail@webmail-04.arcor-online.net>
Date: Sun, 14 Aug 2005 01:08:01 +0200 (CEST)
From: thomas.mey3r@arcor.de
To: linux-kernel@vger.kernel.org
Subject: Aw: 2.6.13-rc5 -> 2.6.13-rc6: ACPI patches seems break the kernel
In-Reply-To: <14604408.1123706059756.JavaMail.ngmail@webmail-08.arcor-online.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <14604408.1123706059756.JavaMail.ngmail@webmail-08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 84.58.112.33
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello.

2.6.13-rc6-git5 resolves my kernel hang problem. seems to be the undo of the pci.c patch (or the pci quirk patch?)

wiht kind regards
thomas

----- Original Nachricht ----
Von:     thomas.mey3r@arcor.de
An:      linux-kernel@vger.kernel.org
Datum:   10.08.2005 22:34
Betreff: 2.6.13-rc5 -> 2.6.13-rc6: ACPI patches seems break the kernel

> Hello.
> My machine (i386, acer 1350) stops to work with 2.6.13-rc6. it works with
> "acpi=off". the abend seems to be a total deadlock. no system request keys
> works. no oops with log level 9.
> could someone please have a look at this?
> 
> with kind regards
> thomas
> 
> ps:
> please carbon copy me, because i'm not on the list.
> 
> 
