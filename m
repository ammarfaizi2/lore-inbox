Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281787AbRKQRxH>; Sat, 17 Nov 2001 12:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281788AbRKQRw6>; Sat, 17 Nov 2001 12:52:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18191 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281787AbRKQRwp>; Sat, 17 Nov 2001 12:52:45 -0500
Subject: Re: [patch] scheduler cache affinity improvement in 2.4 kernels by Ingo Molnar
To: partha@us.ibm.com (Partha Narayanan)
Date: Sat, 17 Nov 2001 18:00:37 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF130223C2.EFFE9842-ON85256B07.0052CC33@raleigh.ibm.com> from "Partha Narayanan" at Nov 17, 2001 10:58:05 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1659ld-0007pU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>      The UniProcessor throughput  was reduced by 40%.
>      The 4-way throughput showed a very slight degradation of 1%.
>      The 8-way throughput showed an improvemnet of 10%.

This is the 10 billion thread volcanomark stuff though I assume ? What
happens in the real world ?
