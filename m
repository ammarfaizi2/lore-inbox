Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319185AbSHMXW1>; Tue, 13 Aug 2002 19:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319182AbSHMXV3>; Tue, 13 Aug 2002 19:21:29 -0400
Received: from antigonus.hosting.pacbell.net ([216.100.98.13]:56261 "EHLO
	antigonus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S319181AbSHMXVB>; Tue, 13 Aug 2002 19:21:01 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: <linux-kernel@vger.kernel.org>
Subject: Cache coherency and snooping
Date: Tue, 13 Aug 2002 16:22:31 -0700
Message-ID: <0a9a01c24320$4c936de0$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.SOL.4.44.0208131856550.25942-100000@rastan.gpcc.itd.umich.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

How can I define a certain region of memory so that it is never cached? I
want to use non-cached region of memory to communicate to my PCI device to
avoid system overhead in cache snooping.

Thanks,
Imran.




