Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262894AbVF3Pab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbVF3Pab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 11:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbVF3Pa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 11:30:26 -0400
Received: from dmailman.com ([65.125.9.75]:31505 "EHLO dmailman.com")
	by vger.kernel.org with ESMTP id S262894AbVF3PaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 11:30:22 -0400
From: <ugenn@dmailman.com>
Subject: 2.6.12: apm / clock issues.
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro Web Mailer v.3.5.7
Date: Thu, 30 Jun 2005 11:40:51 -0400
Message-ID: <web-14590511@dmailman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from 2.6.12, when going into user standby, my system clock gets reset. Previously, user standby would generate an event for apmd which invokes the apmd_proxy script to restore the clock, but it's no longer functioning from 2.6.12 onwards. Anyone experiencing something similar?
__________________________________________________________
Get your Private, Free Email from HTTP://www.DmailMan.Com
