Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbVH3J6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbVH3J6m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 05:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVH3J6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 05:58:42 -0400
Received: from web53607.mail.yahoo.com ([206.190.37.40]:57989 "HELO
	web53607.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750871AbVH3J6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 05:58:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=RGVQ5AGbq3s6PzoJJH56j256wiEj0n1GxZgnR5gkWdg3mBbKQeXdYhPAwFGOufz8qvqtKyR+QBT1oc8i/abkB7dDXxS4m/rj6anb+Fc5idZaujkvhaeQRoyvlrRWovxvejqEhFEpEBp40hjUfj/kSsbWRr0dUKOIKI4n6sZP4Vc=  ;
Message-ID: <20050830095837.27383.qmail@web53607.mail.yahoo.com>
Date: Tue, 30 Aug 2005 19:58:37 +1000 (EST)
From: Steve Kieu <haiquy@yahoo.com>
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43142D4C.6030804@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Are you using skge or sk98lin?

sk98lin

thanks

> 
> > It is working as normal with 2.6.12 and winXP
> before.
> > Today I did upgrade the kernel to 2.6.13 and it
> still
> > works. The problem is now I switch to the older
> kernel
> > that is 2.6.12.5 and .6  it no longer works. dmesg
> > shows like this:
> >      
> > eth0: Yukon Gigabit Ethernet 10/100/1000Base-T
> Adapter
> >       PrefPort:A  RlmtMode:Check Link State
> > 
> > 
> > Boot window XP now, and the link always shows that
> > media disconnected. So the NIC is unuseable with
> > WinXP, 2.6.12  __but__ still works with 2.6.13.
> and
> > power off the machine does not restore the NIC. 
> 


S.KIEU


	

	
		
____________________________________________________ 
Do you Yahoo!? 
The New Yahoo! Movies: Check out the Latest Trailers, Premiere Photos and full Actor Database. 
http://au.movies.yahoo.com
