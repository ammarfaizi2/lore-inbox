Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316047AbSHIRzk>; Fri, 9 Aug 2002 13:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316106AbSHIRzk>; Fri, 9 Aug 2002 13:55:40 -0400
Received: from antigonus.hosting.pacbell.net ([216.100.98.13]:32502 "EHLO
	antigonus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S316047AbSHIRzj>; Fri, 9 Aug 2002 13:55:39 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel memory swap..
Date: Fri, 9 Aug 2002 10:57:26 -0700
Message-ID: <09b101c23fce$398781f0$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.44.0208091045450.2569-100000@betelgeuse.compendium-tech.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

If I allocate some memory using kmalloc() in the linux device driver and
will it ever be swapped to hard disk? If yes, then how can I lock the page?

Thanks,
Imran.

