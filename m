Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbTISNGk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 09:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTISNGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 09:06:40 -0400
Received: from host-38.mier.com ([198.138.183.38]:26057 "EHLO wwwsrvr")
	by vger.kernel.org with ESMTP id S261553AbTISNGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 09:06:39 -0400
From: "Dan Van Derveer" <dan@cyberkni.net>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Logitech Wireless Elite Keyboard
Date: Fri, 19 Sep 2003 09:06:33 -0400
Message-ID: <001a01c37eae$da29d610$0203a8c0@dandesktop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The keyboard produces unknown scancodes and escape sequences at
(seemingly)random intervals. I receive this message when I am at the
console:
keyboard: unknown e1 escape sequence
keyboard: unknown e1 escape sequence
keyboard: unrecognized scancode (65) - ignored

This issue also manifests itself in Xfree86 as a q character.

Where should I start to begin to fix this?

Dan Van Derveer

