Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262927AbTCSF37>; Wed, 19 Mar 2003 00:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262929AbTCSF37>; Wed, 19 Mar 2003 00:29:59 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:3581 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id <S262927AbTCSF37>;
	Wed, 19 Mar 2003 00:29:59 -0500
From: "Edward Killips" <camber@yakko.cs.wmich.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Promise controller not initialized
Date: Wed, 19 Mar 2003 00:40:54 -0500
Message-ID: <KBEEKIACHJMAEEGDLMOMIEEJCCAA.camber@yakko.cs.wmich.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernels 2.4.21-pre5 and 2.4.21-pre5-ac3 do not configure the promise 20276
controller on my Gigabyte GA-7VAXP motherboard. Everything works fine if I
use kernel 2.4.21-pre5 with Andre's ide patch.
---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.462 / Virus Database: 261 - Release Date: 3/13/2003

