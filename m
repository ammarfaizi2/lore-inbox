Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262705AbREVSXt>; Tue, 22 May 2001 14:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262708AbREVSXj>; Tue, 22 May 2001 14:23:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40210 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262705AbREVSXb>; Tue, 22 May 2001 14:23:31 -0400
Subject: Re: Changes in Kernel
To: prasad_s@gdit.iiit.net (Prasad)
Date: Tue, 22 May 2001 19:20:17 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0105230000330.1601-100000@gdit.iiit.net> from "Prasad" at May 23, 2001 12:03:51 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152GlV-0002Hh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   We are interested in making some changes to the linux kernel so that it
> supports some indian type fonts on the console... so what are the special
> things that we sould take care of so that our work would be included in
> the kernel-distribution, and how do we proceed about getting it included
> in the distributions?

Are there specific reasons you cannot just use the existing ioctls to load
fonts ? The console driver already supports Klingon for example.

What are the issues - writing right - left ?

Alan

