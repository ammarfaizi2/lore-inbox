Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265996AbRF1PeQ>; Thu, 28 Jun 2001 11:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265995AbRF1PeH>; Thu, 28 Jun 2001 11:34:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35597 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265993AbRF1Pdw>; Thu, 28 Jun 2001 11:33:52 -0400
Subject: Re: 2.4.6-pre6 cs46xx build error with CONFIG_SOUND_FUSION=m
To: scole@lanl.gov
Date: Thu, 28 Jun 2001 16:33:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01062808522801.01469@spc.esa.lanl.gov> from "Steven Cole" at Jun 28, 2001 08:52:28 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FdnX-00076n-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With CONFIG_SOUND_FUSION=m, I get the following error for 2.4.6-pre6 during
> make modules:

> I've got a number of older 2.4.[3,4,5] kernels, so I'll go back and try to 
> figure out when the change occured, but this is the first time I've seen 
> this particular build error. 

I've fixed the build bug in ac20.. just uploading now

