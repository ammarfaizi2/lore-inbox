Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263971AbRFKUaj>; Mon, 11 Jun 2001 16:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264016AbRFKUaa>; Mon, 11 Jun 2001 16:30:30 -0400
Received: from server1.cosmoslink.net ([208.179.167.101]:31356 "EHLO
	server1.cosmoslink.net") by vger.kernel.org with ESMTP
	id <S264008AbRFKUaR>; Mon, 11 Jun 2001 16:30:17 -0400
Message-ID: <011701c0f2b5$4d2d7140$50a6b3d0@Toshiba>
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
Subject: Task Switching in Linux
Date: Mon, 11 Jun 2001 13:30:02 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In Linux , If we assume that there are only 2 tasks A and B and both are
equal , this is correct or not :-

TASK A -> schedule -> switch_to -> TASK B -> schedule -> switch_to ->
schedule -> switch_to -> TASK A.

Thank you,

Best Regards,

Jaswinder.
--
These are my opinions not 3Di.




