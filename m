Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289961AbSAKOKy>; Fri, 11 Jan 2002 09:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289963AbSAKOKo>; Fri, 11 Jan 2002 09:10:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10501 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289961AbSAKOKc>; Fri, 11 Jan 2002 09:10:32 -0500
Subject: Re: [PATCH] suser to capable changes in char driver
To: bole@falcon.etf.bg.ac.yu (Bosko Radivojevic)
Date: Fri, 11 Jan 2002 14:22:03 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201111425230.1674-100000@falcon.etf.bg.ac.yu> from "Bosko Radivojevic" at Jan 11, 2002 02:27:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16P2ZH-0007m9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was in doubt about this. Maybe CAP_SYS_ADMIN is better?

Think so - thats what suser() itself did so it cant be worse 8)
