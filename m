Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267001AbRGMKnh>; Fri, 13 Jul 2001 06:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267002AbRGMKn1>; Fri, 13 Jul 2001 06:43:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57104 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267001AbRGMKnR>; Fri, 13 Jul 2001 06:43:17 -0400
Subject: Re: SOMAXCONN - bump up or sysctl?
To: thockin@sun.com (Tim Hockin)
Date: Fri, 13 Jul 2001 11:44:08 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3B4E7EA1.F904DC43@sun.com> from "Tim Hockin" at Jul 12, 2001 09:52:49 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15L0Qa-0007it-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We have a request to bump up SOMAXCONN.  Are there are repurcussions to
> doing so?  Would it be better to make it a sysctl?

Its pretty meaningless as a value. People who say they need a larger
SOMAXCONN are as a general rule simply wrong in the Linux case


