Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSILOGx>; Thu, 12 Sep 2002 10:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSILOGw>; Thu, 12 Sep 2002 10:06:52 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:10741
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315721AbSILOGw>; Thu, 12 Sep 2002 10:06:52 -0400
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Todd Underwood <todd@osogrande.com>
Cc: jamal <hadi@cyberus.ca>, "David S. Miller" <davem@redhat.com>,
       "tcw@tempest.prismnet.com" <tcw@tempest.prismnet.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "netdev@oss.sgi.com" <netdev@oss.sgi.com>,
       patricia gilfeather <pfeather@cs.unm.edu>
In-Reply-To: <Pine.LNX.4.44.0209120729200.27963-100000@gp>
References: <Pine.LNX.4.44.0209120729200.27963-100000@gp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 12 Sep 2002 15:11:23 +0100
Message-Id: <1031839883.2994.84.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-12 at 14:57, Todd Underwood wrote:
> thanks.  although i'd love to take credit, i don't think that the 
> reverse-order fragmentation appreciation is all that original:  who 
> wouldn't want their data sctructure size determined up-front? :-) (not to 
> mention getting header-overwriting for-free as part of the single copy.

As far as I am aware it was original when Linux first did it (and we
broke cisco pix, some boot proms, some sco in the process). Credit goes
to Arnt Gulbrandsen probably better known nowdays for his work on Qt

