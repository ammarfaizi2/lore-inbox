Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbTDQSGy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 14:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTDQSGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 14:06:54 -0400
Received: from tag.witbe.net ([81.88.96.48]:42246 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S261884AbTDQSGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 14:06:53 -0400
From: "Paul Rolland" <rol@as2917.net>
To: "'Randy.Dunlap'" <rddunlap@osdl.org>,
       "'Mads Christensen'" <mfc@krycek.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: cannot boot 2.5.67
Date: Thu, 17 Apr 2003 20:18:47 +0200
Message-ID: <01b501c3050d$ca10d3c0$6400a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <20030417105436.3c70b895.rddunlap@osdl.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> There was also a thread about 1 week ago that indicated that
> if CONFIG_LOG_BUF_SHIFT=<some very large number here>,
> the kernel won't boot and won't tell you why.
> 
Gosh !!! You are right.... How stupid I am !!!

I wanted to increase the log size I saw without thinking it
was a SHIFT... So I moved from 16 to 32, dreaming it was a move
from 16K to 32K...

Sh*t.... I read that on the list a few days ago, laught a lot, and
now I'm cooked ;-(

Regards,
Paul

