Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143412AbREKWPH>; Fri, 11 May 2001 18:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143414AbREKWO5>; Fri, 11 May 2001 18:14:57 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:39322 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S143412AbREKWOn>;
	Fri, 11 May 2001 18:14:43 -0400
Message-ID: <3AFC6451.78164EA1@mandrakesoft.com>
Date: Fri, 11 May 2001 18:14:41 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mads Martin =?iso-8859-1?Q?J=F8rgensen?= <mmj@suse.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac8 now with added correct EXTRAVERSION
In-Reply-To: <E14yJEw-0001dW-00@the-village.bc.nu> <20010511141521.A632@suse.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mads Martin Jørgensen wrote:
> 
> * Alan Cox <alan@lxorguk.ukuu.org.uk> [May 11. 2001 13:18]:
> > 2.4.4-ac8
> > o     Tulip driver updates                            (Jeff Garzik)
> 
> Networking stopped working with this kernel. I have the following
> NIC:

Can you define TULIP_DEBUG to 4 in drivers/net/tulip/tulip.h and e-mail
me the 'dmesg' output?

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
