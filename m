Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbVHJUeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbVHJUeV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 16:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbVHJUeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 16:34:21 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:29421 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030258AbVHJUeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 16:34:21 -0400
Message-ID: <8017349.1123706059823.JavaMail.ngmail@webmail-08.arcor-online.net>
Date: Wed, 10 Aug 2005 22:34:19 +0200 (CEST)
From: thomas.mey3r@arcor.de
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc5 -> 2.6.13-rc6: ACPI patches seems break the kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 84.58.106.194
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
My machine (i386, acer 1350) stops to work with 2.6.13-rc6. it works with "acpi=off". the abend seems to be a total deadlock. no system request keys works. no oops with log level 9.
could someone please have a look at this?

with kind regards
thomas

ps:
please carbon copy me, because i'm not on the list.


