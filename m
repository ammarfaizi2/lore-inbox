Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292666AbSDDO7i>; Thu, 4 Apr 2002 09:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313183AbSDDO7e>; Thu, 4 Apr 2002 09:59:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5389 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292666AbSDDO7R>; Thu, 4 Apr 2002 09:59:17 -0500
Subject: Re: 2.4.19-pre4-ac4 kills my gdm
To: mcmanus@ducksong.com (Patrick R. McManus)
Date: Thu, 4 Apr 2002 16:16:24 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020404142308.GA1177@ducksong.com> from "Patrick R. McManus" at Apr 04, 2002 09:23:08 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16t8yO-00068s-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> X does start successfully.. but not gdm. I can go to runlevel 3 and
> run startx without a problem (i.e. get a window manager, etc..)
> 
> If I boot back to 2.4.19-pre4-ac3 all is well again.
> 

Can you do a clean build with pre4-ac4 for non athlon cpu, try that, then
a clean built back to with athlon cpu just to verify that is the actual
issue ?

