Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132222AbRALFUw>; Fri, 12 Jan 2001 00:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132941AbRALFUl>; Fri, 12 Jan 2001 00:20:41 -0500
Received: from [198.167.161.1] ([198.167.161.1]:12392 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S132222AbRALFUZ>;
	Fri, 12 Jan 2001 00:20:25 -0500
Message-ID: <3A5E93EB.AF6FB641@isn.net>
Date: Fri, 12 Jan 2001 01:19:39 -0400
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.1-pre3 UP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think you missed an ifdef in ksyms,
We don't all have smp 
also update Makefile
Garst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
