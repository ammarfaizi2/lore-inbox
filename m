Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135250AbREBOHF>; Wed, 2 May 2001 10:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135276AbREBOG4>; Wed, 2 May 2001 10:06:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64015 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135250AbREBOGp>; Wed, 2 May 2001 10:06:45 -0400
Subject: Re: randon number generator in kernel..
To: deepika@sasken.com (Deepika Kakrania)
Date: Wed, 2 May 2001 15:10:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.30.0105021918490.21323-100000@suns3.sasi.com> from "Deepika Kakrania" at May 02, 2001 07:24:39 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uxKy-0003f0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Can anyone tell me whether there is already any function to generate
> random number inside kernel. If there is one what is that?

Take a look at drivers/char/random.c
