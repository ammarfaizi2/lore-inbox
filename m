Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263428AbTFPJoY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 05:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTFPJoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 05:44:24 -0400
Received: from host203.cisp.cc ([65.196.203.203]:45069 "EHLO
	nocmailsvc003.allthesites.org") by vger.kernel.org with ESMTP
	id S263428AbTFPJoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 05:44:24 -0400
From: "Thomas Molina" <tmolina@copper.net>
To: "Peter Osterlund" <petero2@telia.com>, "Thomas Molina" <tmolina@cox.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: presario laptop and 2.5.71
Date: Mon, 16 Jun 2003 05:56:51 -0400
Message-ID: <MIECJFNNBOIGKGCCGDDEGELGCAAA.tmolina@copper.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think this is some kind of build problem. The messages you quote
> should not even be compiled into the kernel if you disable
> CONFIG_MOUSE_PS2_SYNAPTICS in the kernel configuration.

You are probably right since I've tried it with CONFIG_MOUSE_PS2_SYNAPTICS
defined and undefined as noted in the original message

