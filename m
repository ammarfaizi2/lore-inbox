Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTETHol (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 03:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbTETHol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 03:44:41 -0400
Received: from netmail02.services.quay.plus.net ([212.159.14.221]:64241 "HELO
	netmail02.services.quay.plus.net") by vger.kernel.org with SMTP
	id S263620AbTETHok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 03:44:40 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Randy.Dunlap" <rddunlap@osdl.org>, "Andrew Morton" <akpm@digeo.com>
Cc: <jamagallon@able.es>, <ricklind@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, <lm@bitmover.com>, <cs@tequila.co.jp>
Subject: RE: [PATCH] Documentation for iostats
Date: Tue, 20 May 2003 08:57:44 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAOECEDBAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <20030519163816.66489368.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy.

 > There are 3 widely-used date formats, but only one standard one.
 >
 > 05/15/2003  (US et al order; the worst of the 3 IMO :)
 > 15/05/2003  (or your 15 May 2003)
 > 2003/05/15  (ISO standard)

The above is just plain wrong...

05/15/2003  - US style
15/05/2003  - European style
2003/05/15  - Japanese numeric style

2003-May-15 - Japanese text style
15-May-2003 - UK style
2003-05-15  - ISO style

Personally, I find any of the last group to be perfectly readable,
but find the first group (especially the first two) plain confusing.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.481 / Virus Database: 277 - Release Date: 13-May-2003

