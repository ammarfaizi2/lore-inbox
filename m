Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310695AbSCRNHg>; Mon, 18 Mar 2002 08:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310737AbSCRNHQ>; Mon, 18 Mar 2002 08:07:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43020 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310695AbSCRNHI>; Mon, 18 Mar 2002 08:07:08 -0500
Subject: Re: Another entry for the MCE-hang list
To: Weimer@CERT.Uni-Stuttgart.DE (Florian Weimer)
Date: Mon, 18 Mar 2002 13:23:10 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87n0x63ugq.fsf@CERT.Uni-Stuttgart.DE> from "Florian Weimer" at Mar 18, 2002 01:56:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mx6U-00053V-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> |  - Make sure you have gcc-2.91.66 (egcs-1.1.2) available.  gcc 2.95.2 may
> |    also work but is not as safe, and *gcc 2.7.2.3 is no longer supported*.
> |    Also remember to upgrade your binutils package (for as/ld/nm and company)
> |    if necessary. For more information, refer to ./Documentation/Changes.
> 
> (2.4.18 linux/README)

 - Make sure you have gcc 2.95.3 available.  gcc 2.91.66 (egcs-1.1.2) may
   also work but is not as safe, and *gcc 2.7.2.3 is no longer supported*.
   Also remember to upgrade your binutils package (for as/ld/nm and company)
   if necessary. For more information, refer to ./Documentation/Changes.

(2.4.19pre3 linux/README)
