Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263416AbRFNRT5>; Thu, 14 Jun 2001 13:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263421AbRFNRTr>; Thu, 14 Jun 2001 13:19:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2829 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263416AbRFNRT2>; Thu, 14 Jun 2001 13:19:28 -0400
Subject: Re: [PATCH] Some error checking on kmalloc()'s in ide-probe.c
To: diamond@skynet.ie (Stephen Shirley)
Date: Thu, 14 Jun 2001 18:17:35 +0100 (BST)
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.32.0106141428530.3530-100000@skynet> from "Stephen Shirley" at Jun 14, 2001 02:34:29 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15AakR-0004xE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mornin,
> 	This patch adds error checking to the return value of kmalloc() in
> 2 places in ide-probe.c. It's against 2.4.5.y

These are already fixed in the -ac tree

Please people - check the -ac tree before wasting time on these

