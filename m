Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135658AbRDXOt7>; Tue, 24 Apr 2001 10:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135656AbRDXOtu>; Tue, 24 Apr 2001 10:49:50 -0400
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:2572 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S135658AbRDXOtg>;
	Tue, 24 Apr 2001 10:49:36 -0400
Date: Tue, 24 Apr 2001 07:50:18 -0700 (PDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Alexander Viro <viro@math.psu.edu>, "Mohammad A. Haque" <mhaque@haque.net>,
        ttel5535@artax.karlin.mff.cuni.cz,
        "Mike A. Harris" <mharris@opensourceadvocate.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
In-Reply-To: <E14s3du-00029R-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10104240746500.3535-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2001, Alan Cox wrote:

> > On Tue, 24 Apr 2001, Mohammad A. Haque wrote:
> > > Correct. <1024 requires root to bind to the port.
> > ... And nothing says that it should be done by daemon itself.
> 
> Or that you shouldnt let inetd do it for you
> And that you shouldn't drop the capabilities except that bind
> 
> It is possible to implement the entire mail system without anything running
> as root but xinetd.
> 
Qmail does exactly this afik.  

I've always found the root < 1024 to be quite limmited and find myself
wishing I could assign permissions based on ip/port. 

	Gerhard

 

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

