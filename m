Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135382AbRAGQpZ>; Sun, 7 Jan 2001 11:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135483AbRAGQos>; Sun, 7 Jan 2001 11:44:48 -0500
Received: from denise.shiny.it ([194.20.232.1]:60433 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S135443AbRAGQoO>;
	Sun, 7 Jan 2001 11:44:14 -0500
Message-ID: <3A58CF97.40A30579@denise.shiny.it>
Date: Sun, 07 Jan 2001 15:20:39 -0500
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.18 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Metadata flush interval
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.2.18, SMP.

It seems that anything I write in /proc/sys/vm/bdflush does not make
any difference. Metadata is always flushed every 5 seconds.


Bye.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
