Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278829AbRJZSlB>; Fri, 26 Oct 2001 14:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278831AbRJZSkn>; Fri, 26 Oct 2001 14:40:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16141 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278829AbRJZSkh>; Fri, 26 Oct 2001 14:40:37 -0400
Subject: Re: [PATCH] sparc64 fix for 2.4.13-ac2
To: MikeW@rren.org (Mike Warren)
Date: Fri, 26 Oct 2001 19:47:10 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <200110261835.MAA14684@infomesa.com> from "Mike Warren" at Oct 26, 2001 12:35:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15xC0c-00010d-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sparc64 compiles of recent ac kernels are failing due to a missing
> #define of INIT_MMAP.  This code was removed in patch-2.4.10, but was
> also erroneously removed from the ac branch where it is still required.

Thanks I'll fold that into -ac
