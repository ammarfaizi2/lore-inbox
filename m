Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281181AbRKYWuw>; Sun, 25 Nov 2001 17:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281183AbRKYWuc>; Sun, 25 Nov 2001 17:50:32 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:29705 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S281181AbRKYWu0>;
	Sun, 25 Nov 2001 17:50:26 -0500
Message-Id: <200111252250.fAPMo7wM012678@sleipnir.valparaiso.cl>
To: Tom Eastep <teastep@shorewall.net>
cc: Hartmut Holz <hartmut.holz@arcormail.de>, linux-kernel@vger.kernel.org
Subject: Re: Input/output error 
In-Reply-To: Your message of "Fri, 23 Nov 2001 11:10:25 -0800."
             <20011123191025.D74BDAD02@mail.shorewall.net> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sun, 25 Nov 2001 19:50:06 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Eastep <teastep@shorewall.net> said:

[...]

> A "me too" here (2.4.15 final) -- ran fsck on the /var partition and saw 
> output similar to that below.
> >
> > e2fsck output:
> > --------------
> > Pass 1: Checking inodes, blocks, and sizes
> > Pass 2: Checking directory structure
> > Entry 'kudzu' in /lock/subsys (30001) has deleted/unused inode 30005.
> > Clear? yes
> >
> > Entry 'network' in /lock/subsys (30001) has deleted/unused inode 30006.
> >   Clear? yes

[Ad nauseam]

Saw this with 2.4.15pre[89]
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
