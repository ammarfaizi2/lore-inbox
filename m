Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312489AbSDEMMa>; Fri, 5 Apr 2002 07:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312494AbSDEMMU>; Fri, 5 Apr 2002 07:12:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65285 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312489AbSDEMMN>; Fri, 5 Apr 2002 07:12:13 -0500
Subject: Re: Busy buffers in invalidate
To: reality@delusion.de (Udo A. Steinberg)
Date: Fri, 5 Apr 2002 13:29:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <3CAD91D7.53D03FBC@delusion.de> from "Udo A. Steinberg" at Apr 05, 2002 02:00:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tSqM-0008A9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With 2.4.18 we recently get a lot of the following in the kernel log:
> invalidate: busy buffer
> 
> Something to worry about?

Yes in some situations. Its fixed in 2.4.19pre5-ac2 and a bit before
