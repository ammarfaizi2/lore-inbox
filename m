Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVIYSp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVIYSp1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 14:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbVIYSp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 14:45:26 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:2758 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932261AbVIYSpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 14:45:25 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 0/3] swsusp: fix some obscure bugs
Date: Sun, 25 Sep 2005 20:18:36 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509252018.36867.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series of patches fixes some obscure bugs in swsusp.

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

