Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271995AbRJBLh3>; Tue, 2 Oct 2001 07:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272158AbRJBLhT>; Tue, 2 Oct 2001 07:37:19 -0400
Received: from mail.berlin.de ([195.243.105.33]:33500 "EHLO
	mailoutvl21.berlin.de") by vger.kernel.org with ESMTP
	id <S271995AbRJBLhL>; Tue, 2 Oct 2001 07:37:11 -0400
Message-ID: <3BB9A6F4.6BDDAA81@berlin.de>
Date: Tue, 02 Oct 2001 13:37:24 +0200
From: Norbert Roos <n.roos@berlin.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: printk while interrupts are disabled
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Simple question: Do printk()s get printed while interrupts are disabled
(after cli)?

Thanks

Norbert
