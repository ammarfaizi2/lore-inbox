Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268963AbUIXRcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268963AbUIXRcS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 13:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268959AbUIXR3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 13:29:09 -0400
Received: from fire.osdl.org ([65.172.181.4]:38544 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S268944AbUIXR03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 13:26:29 -0400
Subject: 8 New compile/sparse warnings (overnight build)
From: John Cherry <cherry@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1096046780.2721.24.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 24 Sep 2004 10:26:20 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resuming the reports for sparse warning changes...

Summary:
   New warnings = 8
   Fixed warnings = 134

New warnings:
-------------
drivers/atm/ambassador.c:2297: warning: unsigned int format, long
unsigned int arg (arg 2)

drivers/atm/eni.c:1318:8: warning: Using plain integer as NULL pointer

drivers/atm/eni.c:1352:15: warning: Using plain integer as NULL pointer

drivers/atm/eni.c:1426:23: warning: Using plain integer as NULL pointer

drivers/atm/eni.c:1447:25: warning: Using plain integer as NULL pointer

drivers/atm/eni.c:1745:12: warning: cast removes address space of
expression

drivers/atm/eni.c:248:39: warning: Using plain integer as NULL pointer

drivers/atm/eni.c:263:31: warning: Using plain integer as NULL pointer


Fixed warnings:
---------------
(too many to list)


