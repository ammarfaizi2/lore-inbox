Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbSJUESw>; Mon, 21 Oct 2002 00:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbSJUESw>; Mon, 21 Oct 2002 00:18:52 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:33805
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S264729AbSJUESu>; Mon, 21 Oct 2002 00:18:50 -0400
Date: Sun, 20 Oct 2002 21:22:23 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Sandy Harris <sandy@storm.ca>
cc: Mitsuru KANDA <mk@linux-ipv6.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, cryptoapi-devel@kerneli.org,
       design@lists.freeswan.org, usagi@linux-ipv6.org
Subject: Re: [Design] [PATCH] USAGI IPsec
In-Reply-To: <3DB41338.3070502@storm.ca>
Message-ID: <Pine.LNX.4.10.10210202120100.674-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is all bolted togather and does not need to be piece from random parts.
Thus in simple reality, it is superior.

Maybe FreeS/WAN will get busy and compete or die.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Mon, 21 Oct 2002, Sandy Harris wrote:

> Mitsuru KANDA wrote:
> 
> >Hello Linux kernel network maintainers,
> >
> >I'm a member of USAGI project.
> >
> >In IPv6 specifications, IPsec is mandatory.
> >
> >We implemented IPsec for Linux IP stack.
> >
> >At present, our implementation includes:
> >	PF_KEY V2 interface,
> >	Security Association Database and
> >	Security Policy Database for whole IP versions,
> >	IPsec for IPv6,(transport, tunnel mode),
> >	IPsec for IPv4 (transport mode),
> >
> >Would you mind checking it ?
> >
> Is this code being checked in to the mainline kernel? Or becoming part 
> of the
> CryptoAPI patch set? Bravo, in either case.
> 
> How does that affect FreeS/WAN development?
> 
> >  
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

