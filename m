Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270651AbRHJVa0>; Fri, 10 Aug 2001 17:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270650AbRHJVaL>; Fri, 10 Aug 2001 17:30:11 -0400
Received: from zeus.kernel.org ([209.10.41.242]:14999 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S270649AbRHJV3q>;
	Fri, 10 Aug 2001 17:29:46 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: <linux-kernel@vger.kernel.org>
Subject: how to check whether other threads are waiting ..
Date: Fri, 10 Aug 2001 14:28:20 -0700
Message-ID: <001701c121e3$612a27d0$6401a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.33.0108102143340.1543-100000@ppro.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

How can I find out in my kernel code that if mutiple threads are waiting for
a particular semaphore?

Thanks,
imran.

