Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSFURG5>; Fri, 21 Jun 2002 13:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316693AbSFURG4>; Fri, 21 Jun 2002 13:06:56 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14086 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316674AbSFURG4>; Fri, 21 Jun 2002 13:06:56 -0400
Subject: Re: [PATCH] SCHED_FIFO and SCHED_RR scheduler fix, kernel 2.2.21
To: bhavesh@avaya.com (Bhavesh P. Davda)
Date: Fri, 21 Jun 2002 18:29:20 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       torvalds@transmeta.com
In-Reply-To: <Pine.LNX.4.44.0206211558070.6781-100000@localhost.localdomain> from "Bhavesh P. Davda" at Jun 21, 2002 04:12:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17LSDo-0001KB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The 2.2.21 kernel was behaving incorrectly for SCHED_FIFO and SCHED_RR 
> scheduling.

Looks fine but I dont want to apply behaviour changing non critical stuff
to 2.2
