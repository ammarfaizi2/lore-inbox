Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318794AbSHLSKv>; Mon, 12 Aug 2002 14:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318795AbSHLSKv>; Mon, 12 Aug 2002 14:10:51 -0400
Received: from hercules.egenera.com ([208.254.46.135]:65038 "HELO
	coyote.egenera.com") by vger.kernel.org with SMTP
	id <S318794AbSHLSKu>; Mon, 12 Aug 2002 14:10:50 -0400
Date: Mon, 12 Aug 2002 14:14:22 -0400
From: Phil Auld <pauld@egenera.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19 revert block_llseek behavior to standard
Message-ID: <20020812141422.K27650@vienna.EGENERA.COM>
References: <20020812120659.B27650@vienna.EGENERA.COM> <1029169257.16424.176.camel@irongate.swansea.linux.org.uk> <20020812123632.E27650@vienna.EGENERA.COM> <1029172448.16424.178.camel@irongate.swansea.linux.org.uk> <20020812135701.G27650@vienna.EGENERA.COM> <1029175566.16421.196.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1029175566.16421.196.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Aug 12, 2002 at 07:06:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rumor has it that on Mon, Aug 12, 2002 at 07:06:06PM +0100 Alan Cox said:
> On Mon, 2002-08-12 at 18:57, Phil Auld wrote
> > > Did it work correctly - the answer I believe is - no it didnt.
> > > 
> > 
> > Fair enough. The higher level fix is a band-aid over bugs in some of 
> > the lower level drivers. 
> > 
> > Thanks for the info. I didn't think that patch would go anywhere,
> > but it did help explain why the change. 
> 
> Do push it for 2.5 - there we have time to find out what it exposes
> 

I sent out a 2.5.31 version as well, although I muffed Al Viro's address. 
I don't know if it really falls under his domain anyway...

Thanks,


Phil

-- 
Philip R. Auld, Ph.D.                  Technical Staff 
Egenera Corp.                        pauld@egenera.com
165 Forest St., Marlboro, MA 01752       (508)858-2600
