Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278789AbRJZRiU>; Fri, 26 Oct 2001 13:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278771AbRJZRiK>; Fri, 26 Oct 2001 13:38:10 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20748 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278781AbRJZRh7>; Fri, 26 Oct 2001 13:37:59 -0400
Subject: Re: Deadlock with linux kernel
To: jgolds@resilience.com (Jeff Golds)
Date: Fri, 26 Oct 2001 18:44:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BD9AC67.C959E3CB@resilience.com> from "Jeff Golds" at Oct 26, 2001 11:33:11 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15xB2K-0000oI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, I don't see any signs of a kernel Oops in the syslog, so that
> doesn't appear to be the problem.

Does the capslock key stil work when it locks up. I suspect you are seeing
a non VM related problem. The VM stuff has tended to be livelocks rather
than hung boxes.
