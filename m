Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318049AbSGRNOP>; Thu, 18 Jul 2002 09:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318050AbSGRNOO>; Thu, 18 Jul 2002 09:14:14 -0400
Received: from 12-237-135-160.client.attbi.com ([12.237.135.160]:62980 "EHLO
	Midgard.attbi.com") by vger.kernel.org with ESMTP
	id <S318049AbSGRNOO> convert rfc822-to-8bit; Thu, 18 Jul 2002 09:14:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
Subject: Re: 2.4.18 is not SMP friendly
Date: Thu, 18 Jul 2002 08:17:12 -0500
User-Agent: KMail/1.4.2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207180817.12217.kelledin+LKML@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 July 2002 08:45 am, Alan Cox wrote:
> On Thu, 2002-07-18 at 11:51, devik wrote:
> > I someone here running 2.4.18 on PII SMP successfully ?
>
> PPro in my case but yes. 2.4.18 ought to be pretty solid
> except for some annoying bugs you'll only hit if you use
> smbfs.

I, too, am running a dual PPro box on 2.4.18.  It's been solid
from the get-go.

By the way, what are these bugs with smbfs?  I haven't hit them
on my dual ppro box, probably because the box never runs as a
samba client (just a samba server).

--
Kelledin
"If a server crashes in a server farm and no one pings it, does
it still cost four figures to fix?"
