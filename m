Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269156AbUJEP02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269156AbUJEP02 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 11:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269059AbUJEPYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:24:03 -0400
Received: from dsl254-100-205.nyc1.dsl.speakeasy.net ([216.254.100.205]:64759
	"EHLO memeplex.com") by vger.kernel.org with ESMTP id S269008AbUJEPRM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:17:12 -0400
From: "Andrew A." <aathan-linux-kernel-1542@cloakmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: High Resolution Timer patches crash with slower DDR memory?
Date: Tue, 5 Oct 2004 11:16:55 -0400
Message-ID: <NFBBICMEBHKIKEFBPLMCEEJGIMAA.aathan-linux-kernel-1542@cloakmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does it make sense to anyone that when I run a 2.6.8.1 system patched with HRT using 2 sticks of PC3200 DDR memory (512Meg total) it
works fine, but when I add a stick of PC2700 DDR memory (3 sticks total to 1024Meg) it throws kernel panics and page fault errors?
Same system running an unpatched kernel has no problems.

A.


