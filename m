Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272702AbRIGPIp>; Fri, 7 Sep 2001 11:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272704AbRIGPIf>; Fri, 7 Sep 2001 11:08:35 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36359 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272702AbRIGPIQ>; Fri, 7 Sep 2001 11:08:16 -0400
Subject: Re: hamachi (GNIC-II) and 2.4.9-ac9
To: lpz@ciit.y12.doe.gov (Lawrence MacIntyre)
Date: Fri, 7 Sep 2001 16:12:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3B98E111.B1251D12@ciit.y12.doe.gov> from "Lawrence MacIntyre" at Sep 07, 2001 11:00:34 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15fNIw-0001pz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> except that the hamachi won't work.  ifconfig shows no packets received,
> but some errors, there are no strange messages in /var/log/messages.  I
> then built the same kernel on the intel box, and the same thing

Curious. There are no hamachi driver differences between 2.4.9 and 2.4.9-ac
so the obvious question is which was the last version it did work ?

