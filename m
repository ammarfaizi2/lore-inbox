Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266210AbUFUMzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266210AbUFUMzJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 08:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266214AbUFUMzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 08:55:09 -0400
Received: from mail.wayne-europe.com ([217.237.173.114]:21779 "EHLO
	wayne-europe.com") by vger.kernel.org with ESMTP id S266210AbUFUMzE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 08:55:04 -0400
Message-Id: <04Jun21.150208cest.332178@gateway.wayne-europe.com>
From: Michael Thonke <MThonke@wayne-europe.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: linux-2.6.7-bk3 and mm1
Date: Mon, 21 Jun 2004 14:55:06 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

maybe someone can help me out of the problem that "make modules_install"
gives me an error
This error appears 

ln: when making multiple links, last argument must be a directory
-bash: ln:: command not found
make: *** [_modinst_] Error 1

I diffed the bk2 file againt the bk3 and mm1 Makefile
so I thought I will find an answer there.But no luck.

Thanks for help and best regards
Michael Thonke

Mit freundlichen Grüßen
_______________________
Wayne Germany 
Dresser Europe GmbH
Organisation / Datenverarbeitung 
Michael Thonke 
Grimsehlstrasse 44
37574 Einbeck * Germany
Telefon +49 55 61- 794-168
Telefax +49 55 61- 794-224
<mailto:MThonke@wayne-europe.com>
<http://www.wayne-europe.com/>
_______________________
