Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSEUTmi>; Tue, 21 May 2002 15:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316575AbSEUTmh>; Tue, 21 May 2002 15:42:37 -0400
Received: from dsl-213-023-030-041.arcor-ip.net ([213.23.30.41]:30852 "EHLO
	duron.intern.kubla.de") by vger.kernel.org with ESMTP
	id <S316574AbSEUTmf>; Tue, 21 May 2002 15:42:35 -0400
Date: Tue, 21 May 2002 21:42:30 +0200
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: DCOM coming?
Message-ID: <20020521194230.GA1470@duron.intern.kubla.de>
In-Reply-To: <D3524C0FFDC6A54F9D7B6BBEECD341D5D56F58@HBMNTX0.da.hbm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 11:47:28AM +0200, Wessler, Siegfried wrote:
> Hello,
> 
> are there any plans to wrap DCOM ability into the Linux kernel "someday"? 
> Or will you wait until .net might be widely acepted and don't go into DCOM
> anyhow? 

Never. Either of it: that stuff belongs into user land.

> Like it or not, but you need DCOM if you want to connect to DCOM organized
> networks, like OPC and others.

So what? They are running on top of IP like everyone else.

Dominik Kubla
-- 
UFO is a SIG at the University of Mainz. Meetings are every odd monday of
the month in the workstation laboratory (Zentrum fuer Datenverarbeitung).
We are a Unix derivate independent group.  Every flavor of Unix is welcome.
