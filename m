Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAEPof>; Fri, 5 Jan 2001 10:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132293AbRAEPoT>; Fri, 5 Jan 2001 10:44:19 -0500
Received: from ANancy-101-1-1-133.abo.wanadoo.fr ([193.251.70.133]:63223 "HELO
	the-babel-tower.nobis.phear.org") by vger.kernel.org with SMTP
	id <S129383AbRAEPoB>; Fri, 5 Jan 2001 10:44:01 -0500
Date: Fri, 5 Jan 2001 16:49:26 +0100 (CET)
From: Nicolas Noble <Pixel@the-babel-tower.nobis.phear.org>
To: Nicolas Parpandet <nparpand@perinfo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel network problem ?
In-Reply-To: <000d01c07724$8fa531f0$8900030a@nicolasp>
Message-ID: <Pine.LNX.4.21.0101051646100.5165-100000@the-babel-tower.nobis.phear.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hi all,
> 
> I'm testing 2.4 series for few weeks,
> even the last prerelease
> 
> I've seen stranges things  :
> 
> I cannot access to some ips adresses ! :
> in http or in smtp using "konqueror", "netscape",
> "mail",  "telnet 25".
> 
> I cannot login to hotmail (in the web page:http) 
> or send mail (smtp) to hotmail users (don't blame me !!)
> All the others network things works well, the network in general seems
> good only very few sites like hotmail doesn't works.
> 
> And only with 2.4 series !! not with 2.2 ...
> 
> maybe it's a glibc or kernel issue, I'dont know.
> I have an intel SMP motherboard connected to the net (cable) 
> with a PCI realtek 8019.
> 
> I didn't analyse packets sent. If somebody else have the
> same problems ...
> 
> Nicolas.
> 
> Sorry for my poor english.
> 
> PS: funny "bug" isn't it ? (hotmail !)
> PS2: thanks for all, very good job done, 
>       2.4 is very fast and seems stable.
> 

I noticed the same bug. This is very weired, I can send a list of sites
which I can't connect anymore. I've "solved" the problem by installing a
gateway onto a 2.2.18 with a squid on it, so this is the squid which is
doing the http's traffic for my 2.4.0 box.

I though it was a misconfiguration from my side but wasn't able to detect
it.

Perhaps it's linked...

  Regards,


  -- Nicolas Noble


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
