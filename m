Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVFBMn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVFBMn1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 08:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVFBMn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 08:43:27 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:61851 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S261398AbVFBMkW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 08:40:22 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Arjan van de Ven'" <arjan@infradead.org>,
       "Mikael Starvik" <mikael.starvik@axis.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Accessing monotonic clock from modules
Date: Thu, 2 Jun 2005 14:40:19 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C7A35@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66802FA3913@exmail1.se.axis.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>For your own kernel it'd be trivial to add that simple export patch
>local...

Certainly, already done that. My original mail was more about checking 
that there wasn't a better way in this particular case and sugest an 
export because others may need it as well.

I'll just keep it in the local repository and let others decide whether
to export or not.

/Mikael

