Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbTLROyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 09:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbTLROyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 09:54:05 -0500
Received: from mail01.mail.esat.net ([193.120.142.6]:20688 "EHLO
	mail01.mail.esat.net") by vger.kernel.org with ESMTP
	id S265200AbTLROyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 09:54:03 -0500
Message-ID: <0d6401c3c576$c6889b00$6e69690a@RIMAS>
From: "Remus" <rmocius@auste.elnet.lt>
To: <linux-kernel@vger.kernel.org>
References: <20031217114125.GA20057@malvern.uk.w2k.superh.com> <3FE08470.5040801@pacbell.net> <20031218143236.GB20057@malvern.uk.w2k.superh.com>
Subject: iproute2 and 2.6.0 kernel
Date: Thu, 18 Dec 2003 14:53:31 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I have a linux box with three NICs (two for external ISP, and one local).
Today I tried to use 2.6.0 kernel and something is wrong, because iproute2
does not work corretly.
No routed packets go via second ISP NIC which I use with iproute rules. With
2.4.22 kernel I have no problems at all with packet routing.

I compiled 2.6.0 kernel myself, maybe I missed something in .config file?

Thanks

Remus

