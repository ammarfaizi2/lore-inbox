Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbUKCHzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUKCHzY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 02:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbUKCHzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 02:55:24 -0500
Received: from krynn.se.axis.com ([193.13.178.10]:3216 "EHLO krynn.se.axis.com")
	by vger.kernel.org with ESMTP id S261440AbUKCHzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 02:55:18 -0500
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Christoph Hellwig'" <hch@infradead.org>,
       "Mikael Starvik" <mikael.starvik@axis.com>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: RE: [PATCH 2/10] CRIS architecture update - Drivers
Date: Wed, 3 Nov 2004 08:54:31 +0100
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C7497@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66801AF7431@exmail1.se.axis.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Where is that driver? Can't find it in 2.6.9.

-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org] 
Sent: Tuesday, November 02, 2004 11:55 PM
To: Mikael Starvik
Cc: linux-kernel@vger.kernel.org; akpm@osdl.org
Subject: Re: [PATCH 2/10] CRIS architecture update - Drivers


Any chance you could share code with drivers/char/ds1302.c so we don't
have two almost identical copies of that driver?

