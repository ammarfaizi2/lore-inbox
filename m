Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311796AbSCNVZS>; Thu, 14 Mar 2002 16:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311797AbSCNVZI>; Thu, 14 Mar 2002 16:25:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10515 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311796AbSCNVY6>; Thu, 14 Mar 2002 16:24:58 -0500
Subject: Re: linux 2.2.21 pre3, pre4 and rc1 problems. (fwd)
To: mikesw@ns1.whiterose.net (M Sweger)
Date: Thu, 14 Mar 2002 21:40:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <Pine.BSF.4.21.0203141518590.18036-100000@ns1.whiterose.net> from "M Sweger" at Mar 14, 2002 03:19:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lcxr-0001wc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> v2.2.21pre4      hangs on boot after the message
> 		 "Intel machine check architecture supported"

Fixed..

> v2.2.21rc1       Oops' on boot after the message "CPU: L2 cache = 512K
>                  with a kernel panic. Note: I don't have any swap turned on.

Also fixed - can you try pre3 ?
