Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314075AbSEAWgH>; Wed, 1 May 2002 18:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314077AbSEAWgG>; Wed, 1 May 2002 18:36:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55300 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314075AbSEAWgF>; Wed, 1 May 2002 18:36:05 -0400
Subject: Re: Kernels 2.2.19-2.4.x. Why why why?
To: dinorage@wp.pl (Eugenij Butusov)
Date: Wed, 1 May 2002 23:54:25 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Alan Cox)
In-Reply-To: <20020501201703.A990@matrix.awr.open.net.pl> from "Eugenij Butusov" at May 01, 2002 08:17:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1732zR-0002jd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> stable. Why Linux doesn't work? The main question is: what was
> changed in kernel from version 2.2.17 to 2.2.19? Is there any

See the 2.2.18/2.2.19 release notes.

Check you built 2.2.17 and 2.2.19 with the same compiler and config options.
See if 2.2.18 works and which 2.2.18pre/2.2.19pre broke it
