Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316204AbSILOjO>; Thu, 12 Sep 2002 10:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316210AbSILOjO>; Thu, 12 Sep 2002 10:39:14 -0400
Received: from puerco.nm.org ([129.121.1.22]:39687 "HELO puerco.nm.org")
	by vger.kernel.org with SMTP id <S316204AbSILOjN>;
	Thu, 12 Sep 2002 10:39:13 -0400
Date: Thu, 12 Sep 2002 08:41:25 -0600 (MDT)
From: todd-lkml@osogrande.com
X-X-Sender: todd@gp
Reply-To: linux-kernel@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: jamal <hadi@cyberus.ca>, "David S. Miller" <davem@redhat.com>,
       "tcw@tempest.prismnet.com" <tcw@tempest.prismnet.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "netdev@oss.sgi.com" <netdev@oss.sgi.com>,
       patricia gilfeather <pfeather@cs.unm.edu>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
In-Reply-To: <1031839883.2994.84.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0209120840290.27963-100000@gp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan,

good to know.  it's a nice piece of engineering.  it's useful to note that 
linux has such a long and rich history of breaking de-facto standards in 
order to make things work better.

t.

On 12 Sep 2002, Alan Cox wrote:

> On Thu, 2002-09-12 at 14:57, Todd Underwood wrote:
> > thanks.  although i'd love to take credit, i don't think that the 
> > reverse-order fragmentation appreciation is all that original:  who 
> > wouldn't want their data sctructure size determined up-front? :-) (not to 
> > mention getting header-overwriting for-free as part of the single copy.
> 
> As far as I am aware it was original when Linux first did it (and we
> broke cisco pix, some boot proms, some sco in the process). Credit goes
> to Arnt Gulbrandsen probably better known nowdays for his work on Qt
> 

-- 
todd underwood, vp & cto
oso grande technologies, inc.
todd@osogrande.com

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin

