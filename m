Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSFFShW>; Thu, 6 Jun 2002 14:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317047AbSFFSg0>; Thu, 6 Jun 2002 14:36:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29196 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317083AbSFFSeJ>;
	Thu, 6 Jun 2002 14:34:09 -0400
Message-ID: <3CFFAA8D.8000106@mandrakesoft.com>
Date: Thu, 06 Jun 2002 14:31:41 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.20 tulip bogosities
In-Reply-To: <200206061624.SAA17598@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael,

Can you try an experiment for me?

Run 2.5.19 with the 2.5.20 tulip.  Just copy drivers/net/tulip/* from 
2.5.20 into 2.5.19.

Nothing changed in 2.5.20 tulip that should cause that, AFAICS.  So I 
want to narrow down the problem before looking further.

    Jeff




