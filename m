Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268766AbUJPPbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268766AbUJPPbo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 11:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268765AbUJPPbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 11:31:44 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2834 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S268766AbUJPPat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 11:30:49 -0400
Date: Sat, 16 Oct 2004 17:30:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Erwin Schoenmakers <esc-solutions@planet.nl>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: while building kernel 2.6.8.1. for Alpha (Miata)
Message-ID: <20041016153017.GE5307@stusta.de>
References: <417139A2.5090705@planet.nl> <20041016191704.A20686@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041016191704.A20686@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 07:17:04PM +0400, Ivan Kokshaysky wrote:
> On Sat, Oct 16, 2004 at 05:09:22PM +0200, Erwin Schoenmakers wrote:
> > Do I need to install another version of the gnu compiler/assembler?
> > I have installed:
> >    gcc version 2.95.4
> >    as version 2.12.90.0.1 using BFD version 2.12.90.0.1
> 
> Yes. Your toolchain is way too old.

What are the required versions on Alpha?

According to Documentation/Changes, Erwin's versions were OK.

> Ivan.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

