Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273996AbRJ0Phi>; Sat, 27 Oct 2001 11:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274774AbRJ0Ph2>; Sat, 27 Oct 2001 11:37:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28420 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273996AbRJ0PhS>; Sat, 27 Oct 2001 11:37:18 -0400
Subject: Re: Non-standard MODULE_LICENSEs in 2.4.13-ac2
To: adilger@turbolabs.com (Andreas Dilger)
Date: Sat, 27 Oct 2001 16:43:14 +0100 (BST)
Cc: kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org
In-Reply-To: <20011027012016.F23590@turbolinux.com> from "Andreas Dilger" at Oct 27, 2001 01:20:16 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15xVcA-0003bG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> but I think you are confusing intent with implementation.  The intent
> (AFAICS) is to mark the kernel tainted ONLY if a closed-source module
> is loaded, rather than to be a "license police" mechanism, especially
> for sources that have been included in the kernel for a long time.

"BSD" can indicate totally closed source material as well as other stuff

Also Keith is right - if it is GPL compatible BSD code linked with the
kernel then its correct to describe it as Dual BSD/GPL anyway
