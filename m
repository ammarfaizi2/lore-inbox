Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbVKZLld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVKZLld (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 06:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVKZLld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 06:41:33 -0500
Received: from ensim03.ffm.m2soft.com ([195.38.20.12]:29614 "EHLO
	ensim03.ffm.m2soft.com") by vger.kernel.org with ESMTP
	id S1750817AbVKZLld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 06:41:33 -0500
X-ClientAddr: 81.223.64.188
Date: Sat, 26 Nov 2005 12:36:53 +0100
From: Nicolas Kaiser <nikai@nikai.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][TRIVIAL] MAINTAINERS: line duplication
Message-ID: <20051126123653.5d535e54@lucky.kitzblitz>
Organization: -
X-Face: "fF&[w2"Nws:JNH4'g|:gVhgGKLhj|X}}&w&V?]0=,7n`jy8D6e[Jh=7+ca|4~t5e[ItpL5
 N'y~Mvi-vJm`"1T5fi1^b!&EG]6nW~C!FN},=$G?^U2t~n[3;u\"5-|~H{-5]IQ2
X-Mailer: Sylpheed-claws (Linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-M2Soft-MailScanner-Information: Please contact the ISP for more information
X-M2Soft-MailScanner: Found to be clean
X-MailScanner-From: nikai@nikai.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

uniq -d MAINTAINERS

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
--- a/MAINTAINERS	2005-11-24 21:43:37.000000000 +0100
+++ b/MAINTAINERS	2005-11-26 12:18:28.000000000 +0100
@@ -915,7 +915,6 @@ S:	Maintained
 FARSYNC SYNCHRONOUS DRIVER
 P:	Kevin Curtis
 M:	kevin.curtis@farsite.co.uk
-M:	kevin.curtis@farsite.co.uk
 W:	http://www.farsite.co.uk/
 S:	Supported
 
