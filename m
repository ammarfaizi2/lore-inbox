Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263021AbREWJLH>; Wed, 23 May 2001 05:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263022AbREWJK5>; Wed, 23 May 2001 05:10:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29960 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263021AbREWJKi>; Wed, 23 May 2001 05:10:38 -0400
Subject: Re: Linux 2.4.4-ac14
To: kaos@ocs.com.au (Keith Owens)
Date: Wed, 23 May 2001 10:07:28 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <7185.990583519@kao2.melbourne.sgi.com> from "Keith Owens" at May 23, 2001 12:05:19 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152Uc4-00039B-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is drivers/char/ser_a2232fw.ax supposed to be included?  Nothing uses it.

Yes. Its the 6502 source to the 2232 firmware we load
