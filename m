Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293400AbSCKAME>; Sun, 10 Mar 2002 19:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293397AbSCKALz>; Sun, 10 Mar 2002 19:11:55 -0500
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:2828 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S293400AbSCKALj>; Sun, 10 Mar 2002 19:11:39 -0500
Subject: Re: Suspend support for IDE
From: Reid Hekman <reid_hekman@yahoo.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020310005213.1D8BB8959A@cx518206-b.irvn1.occa.home.com>
In-Reply-To: <20020310005213.1D8BB8959A@cx518206-b.irvn1.occa.home.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 10 Mar 2002 18:10:14 -0600
Message-Id: <1015805489.15071.10.camel@zeus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-03-09 at 18:52, Barry K. Nathan wrote: 
> > > Why should I tell the drive to power down? It is going to loose its
> > > power, anyway (I believe in both S3 and S4).
> > 
> > So it can shut itself down nicely and do any housework it wants to do
> > (like flushing the cache if the cache flush command isnt supported.. its
> >  optional in older ATA standards)
> 
> Or, in the case of newer IBM TravelStars, so that the drive can unload
> its head properly instead of having to do an uncontrolled emergency unload
> that shortens the drive's life and makes an awful screeching noise.

Eeep. Have we just set the wayback machine for 15 years ago? I don't
remember seeing PARK.COM in /sbin recently. 

Sorry, couldn't resist. 
Reid 



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

