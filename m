Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbTE0TJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263721AbTE0TJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:09:36 -0400
Received: from csl2.consultronics.on.ca ([204.138.93.2]:28804 "EHLO
	csl2.consultronics.on.ca") by vger.kernel.org with ESMTP
	id S263718AbTE0TJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:09:34 -0400
Date: Tue, 27 May 2003 15:22:46 -0400
From: Greg Louis <glouis@dynamicro.on.ca>
To: LKML <linux-kernel@vger.kernel.org>
Subject: patch-2.4.21-rc4-ac1.bz2 on kernel.org is really patch-2.4.21-rc2-ac3?
Message-ID: <20030527192246.GA8570@athame.dynamicro.on.ca>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After trying to apply a freshly downloaded "patch-2.4.21-rc4-ac1.bz2"
from kernel.org and getting 53 rejects, I took a look inside and:
--- linux.21rc2/arch/alpha/kernel/entry.S       2003-05-09
18:05:01.000000000 +0100
+++ linux.21rc2-ac3/arch/alpha/kernel/entry.S   2003-04-22
16:44:36.000000000 +0100

etc.

The .gz patch is the same.

-- 
| G r e g  L o u i s          | gpg public key: finger     |
|   http://www.bgl.nu/~glouis |   glouis@consultronics.com |
| http://wecanstopspam.org in signatures fights junk email |
