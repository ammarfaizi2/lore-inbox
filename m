Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266683AbRGFMwc>; Fri, 6 Jul 2001 08:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266684AbRGFMwX>; Fri, 6 Jul 2001 08:52:23 -0400
Received: from scan2.fhg.de ([153.96.1.37]:53673 "EHLO scan2.fhg.de")
	by vger.kernel.org with ESMTP id <S266683AbRGFMwI>;
	Fri, 6 Jul 2001 08:52:08 -0400
Message-ID: <3B45B46E.B6D71DA0@N-Club.de>
Date: Fri, 06 Jul 2001 14:51:58 +0200
From: Juergen Wolf <JuWo@N-Club.de>
Organization: AEMT Fraunhofer
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Francois Romieu <romieu@cogenit.fr>, linux-kernel@vger.kernel.org
Subject: Re: Problem with SMC Etherpower II + kernel newer 2.4.2
In-Reply-To: <Pine.LNX.4.30.0107021014230.15054-100000@flash.datafoundation.com> <3B42DEC2.AAB1E65B@N-Club.de> <20010704145752.A29311@se1.cogenit.fr> <3B456D45.FBF10C1A@N-Club.de> <20010706134421.B20614@se1.cogenit.fr> <3B45AEBD.8D0599E3@N-Club.de> <3B45B04A.9A85ECA0@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>
> Does it work with this line?
> 
> outl(0x12, ioaddr + MIICfg);
> 

yes, works fine too

Regards,
	Juergen
