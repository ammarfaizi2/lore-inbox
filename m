Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270222AbRHGXXJ>; Tue, 7 Aug 2001 19:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270219AbRHGXW7>; Tue, 7 Aug 2001 19:22:59 -0400
Received: from zeus.kernel.org ([209.10.41.242]:23526 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S270218AbRHGXWs>;
	Tue, 7 Aug 2001 19:22:48 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: <linux-kernel@vger.kernel.org>
Subject: Exporting kernel memory to application
Date: Tue, 7 Aug 2001 15:24:03 -0700
Message-ID: <003501c11f8f$aa9d6270$6401a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <23793.997222354@ocs3.ocs-net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am in a situation where it is required to export a kernel memory
(allocated by kmalloc in the device driver) to the user application. I would
really appreciate any guidance or suggestion.

Thanks,
Imran Badr.

