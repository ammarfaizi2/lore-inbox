Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEPuG>; Fri, 5 Jan 2001 10:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAEPtz>; Fri, 5 Jan 2001 10:49:55 -0500
Received: from ANancy-101-1-1-133.abo.wanadoo.fr ([193.251.70.133]:7160 "HELO
	the-babel-tower.nobis.phear.org") by vger.kernel.org with SMTP
	id <S129183AbRAEPtg>; Fri, 5 Jan 2001 10:49:36 -0500
Date: Fri, 5 Jan 2001 16:55:03 +0100 (CET)
From: Nicolas Noble <Pixel@the-babel-tower.nobis.phear.org>
To: Nicolas Parpandet <nparpand@perinfo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel network problem ?
In-Reply-To: <000d01c07724$8fa531f0$8900030a@nicolasp>
Message-ID: <Pine.LNX.4.21.0101051653130.5165-100000@the-babel-tower.nobis.phear.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I cannot login to hotmail (in the web page:http) 
> or send mail (smtp) to hotmail users (don't blame me !!)
> All the others network things works well, the network in general seems
> good only very few sites like hotmail doesn't works.

By the way, I just tried to connect to hotmail without my squid and,
effectively, it's like all those others sites:

http://www.creative.com
http://www.fnac.com
http://ftpsearch.ntnu.no

I have to use the squid on my 2.2.18 to access to them. A direct connexion
from my 2.4.0 will be refused.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
