Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266623AbSKGX32>; Thu, 7 Nov 2002 18:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266624AbSKGX32>; Thu, 7 Nov 2002 18:29:28 -0500
Received: from ns1.baby-dragons.com ([199.33.245.254]:21904 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S266623AbSKGX32>; Thu, 7 Nov 2002 18:29:28 -0500
Date: Thu, 7 Nov 2002 18:35:37 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Urban Widmark <urban@teststation.com>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: !(smbfs && O_LARGEFILE)
In-Reply-To: <Pine.LNX.4.44.0211072325490.9298-100000@cola.enlightnet.local>
Message-ID: <Pine.LNX.4.44.0211071832180.484-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Urban ,  Have your 0[0-2]-smbfs-2.4.18-* &
	smbfs-2.4.18-uid32.patch been put into 2.4.20-rc1 or
	some simular version of them ?  My main concern it the
	lfs(Large file support ???) .  Tia , JimL

On Thu, 7 Nov 2002, Urban Widmark wrote:
> On Thu, 7 Nov 2002, Roy Sigurd Karlsbakk wrote:
> > hi all
> > When will smbfs support O_LARGEFILE?
> > I mean - smbfs tells me this, mounted from a win2k server
> It's in 2.5. You just need to tell smbmount about it, see:
> http://www.hojdpunkten.ac.se/054/samba/index.html
> /Urban
--
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

