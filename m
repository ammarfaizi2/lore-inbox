Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286384AbRLTVSp>; Thu, 20 Dec 2001 16:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286385AbRLTVSf>; Thu, 20 Dec 2001 16:18:35 -0500
Received: from andiamo.com ([161.58.172.50]:31617 "EHLO andiamo.com")
	by vger.kernel.org with ESMTP id <S286384AbRLTVS0>;
	Thu, 20 Dec 2001 16:18:26 -0500
Reply-To: <rbector@andiamo.com>
From: "Rajeev Bector" <rbector@andiamo.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: LKCD (kernel core dumps)
Date: Thu, 20 Dec 2001 13:12:15 -0800
Message-ID: <GIEMIEJKPLDGHDJKJELACEAMDIAA.rbector@andiamo.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anybody worked on a system to transfer the kernel dump
out to a server once we hit panic (as opposed to dumping
it to disk). This will obviously not work if IP itself is
corrupted. This can be useful in embedded systems where
the local disk is not big enough to store the dump or there
is no disk ?

Does this even make sense to do something like this ?

Thanks for your replies.

Rajeev

