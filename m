Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316832AbSGROJL>; Thu, 18 Jul 2002 10:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317876AbSGROJL>; Thu, 18 Jul 2002 10:09:11 -0400
Received: from iris.mc.com ([192.233.16.119]:23544 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S316832AbSGROJK>;
	Thu, 18 Jul 2002 10:09:10 -0400
Message-Id: <200207181411.KAA06446@mc.com>
Content-Type: text/plain; charset=US-ASCII
From: mbs <mbs@mc.com>
To: "Tommy Faasen" <tommy@vuurwerk.nl>, <devik@cdi.cz>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 is not SMP friendly
Date: Thu, 18 Jul 2002 10:13:27 -0400
X-Mailer: KMail [version 1.3.1]
References: <Pine.LNX.4.33.0207181244550.535-100000@devix> <1026999905.9727.13.camel@irongate.swansea.linux.org.uk> <4579.198.43.100.6.1027000434.squirrel@thuis.zwanebloem.nl>
In-Reply-To: <4579.198.43.100.6.1027000434.squirrel@thuis.zwanebloem.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had problems w/P4 SMP on 2.4.18 and RH2.4.18-3 where after a while 
(30-40 min after boot) it would slow to a crawl, and the disk would be 
constantly going, but CPU usage would be ~0%.  with 2 gigs of RAM and nothing 
running (not even x)....

RH2.4.18-5 does not seem to have the problem.

On Thursday 18 July 2002 09:53, Tommy Faasen wrote:
> > On Thu, 2002-07-18 at 11:51, devik wrote:
> >> I someone here running 2.4.18 on PII SMP successfully ?
>
> No problems on my side, on 2.4.18 and 2.4.18-wolk-3.5rc3.
>
> > PPro in my case but yes. 2.4.18 ought to be pretty solid except for some
> > annoying bugs you'll only hit if you use smbfs.
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
/**************************************************
**   Mark Salisbury       ||      mbs@mc.com     **
** If you would like to sponsor me for the       **
** Mass Getaway, a 150 mile bicycle ride to for  **
** MS, contact me to donate by cash or check or  **
** click the link below to donate by credit card **
**************************************************/
https://www.nationalmssociety.org/pledge/pledge.asp?participantid=86736
