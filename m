Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVGHIKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVGHIKc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 04:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVGHIKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 04:10:32 -0400
Received: from rfhs0023.fh-regensburg.de ([194.95.104.23]:21449 "HELO
	rfhs0023.fh-regensburg.de") by vger.kernel.org with SMTP
	id S262145AbVGHIK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 04:10:29 -0400
From: Markus Boas <ryven@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: useful Bug 2.6.13-rc1-mm1
Date: Fri, 8 Jul 2005 10:09:50 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507081009.50571.ryven@gmx.de>
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.0.3.2, Antispam-Data: 2005.7.8.0
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CD 0, __CT 0, __CTE 0, __CTYPE_CHARSET_QUOTED 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a for my useful bug in 2.6.13-rc1-mm1 but only on x86-64.
With ifdown ifup eth0 I was able to reset the tx and rx bit-counter.
How it is use in x86 enviroment?

Thx
	Ryven
