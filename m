Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263288AbRFEHIH>; Tue, 5 Jun 2001 03:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbRFEHH5>; Tue, 5 Jun 2001 03:07:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22032 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263291AbRFEHHp>; Tue, 5 Jun 2001 03:07:45 -0400
Subject: Re: TRG vger.timpanogas.org hacked
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Tue, 5 Jun 2001 08:05:34 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
In-Reply-To: <20010604183642.A855@vger.timpanogas.org> from "Jeff V. Merkey" at Jun 04, 2001 06:36:42 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E157AuE-0006Wc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> is curious as to how these folks did this.  They exploited BIND 8.2.3
> to get in and logs indicated that someone was using a "back door" in 

Bind runs as root.

> We are unable to determine just how they got in exactly, but they 
> kept trying and created an oops in the affected code which allowed 
> the attack to proceed.  

Are you sure they didnt in fact simply screw up live patching the kernel to
cover their traces

