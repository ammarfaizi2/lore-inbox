Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267619AbUIUMg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267619AbUIUMg0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 08:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267633AbUIUMgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 08:36:25 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:60432 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S267619AbUIUMgT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 08:36:19 -0400
Date: Tue, 21 Sep 2004 14:36:22 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: linux-kernel@vger.kernel.org
Subject: RARP support disapeard in kernel 2.6.x ?
Message-ID: <Pine.LNX.4.60L.0409211432000.15099@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-903867316-1095770182=:15099"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-903867316-1095770182=:15099
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT


I'm just try prepare ARP/RARP/TFTP boot host and ..

# rarp -a
This kernel does not support RARP.
# modprobe rarp
FATAL: Module rarp not found.

[linux-2.6.8.1]$ grep RARP .config
[linux-2.6.8.1]$

What hepen with RARP support in kernel 2.6.x ?

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--8323328-903867316-1095770182=:15099--
