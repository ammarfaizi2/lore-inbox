Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265957AbUFOVGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265957AbUFOVGD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 17:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265962AbUFOVGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 17:06:03 -0400
Received: from ns1.goquest.com ([12.18.108.6]:21644 "HELO mail.goquest.com")
	by vger.kernel.org with SMTP id S265957AbUFOVGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 17:06:01 -0400
X-Qmail-Scanner-Mail-From: fedora@rooker.dyndns.org via mail.goquest.com
X-Qmail-Scanner: 1.20st (Clear:RC:1(67.65.232.5):SA:0(0.0/5.0):. Processed in 7.042969 secs)
Message-ID: <001101c4531c$7a7c6960$3205a8c0@pixl>
From: "Peter Maas" <fedora@rooker.dyndns.org>
To: <linux-kernel@vger.kernel.org>
Subject: 3ware 9500S Drivers (mm kernel)
Date: Tue, 15 Jun 2004 16:05:24 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been using the 3ware 9500 drivers in the mm kernel for a while now
without any problems, this is on a dual opteron with a 9500S-12 controller
with 6 disk formatted as a raid-5. Are these going to be included in the
vanilla kernel soon?

My only complaints with the drivers are that smartctl doesnt work with them
(fedora core 2), and the 3ware management tools from the 3ware cd wont work
with the mm drivers (wont detect controller).

Thanks

Peter Maas

