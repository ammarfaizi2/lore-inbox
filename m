Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264509AbRFJIxA>; Sun, 10 Jun 2001 04:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264511AbRFJIwu>; Sun, 10 Jun 2001 04:52:50 -0400
Received: from beasley.gator.com ([63.197.87.202]:59409 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S264509AbRFJIwf>; Sun, 10 Jun 2001 04:52:35 -0400
From: "George Bonser" <george@gator.com>
To: "Rik van Riel" <riel@conectiva.com.br>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.4.6-pre2 page_launder() improvements
Date: Sun, 10 Jun 2001 01:52:19 -0700
Message-ID: <CHEKKPICCNOGICGMDODJOEJMDEAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <Pine.LNX.4.33.0106100541200.1742-100000@duckman.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> That sounds like the machine just gets a working set
> larger than the amount of available memory. It should
> work better with eg. 96, 128 or more MBs of memory.
>

Right, I run them with 256M ... thought I would try to squeeze it a bit to
see what broke.

