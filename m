Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317691AbSGOXPZ>; Mon, 15 Jul 2002 19:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317692AbSGOXPY>; Mon, 15 Jul 2002 19:15:24 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:24824 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317691AbSGOXPY>; Mon, 15 Jul 2002 19:15:24 -0400
Subject: Re: Linux 2.4.19-rc1-ac5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <agvl00$jjm$1@cesium.transmeta.com>
References: <200207152148.g6FLm7Q24750@devserv.devel.redhat.com>
	<20020715220241Z317668-685+9887@vger.kernel.org> 
	<agvl00$jjm$1@cesium.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 16 Jul 2002 01:28:19 +0100
Message-Id: <1026779299.32689.46.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-16 at 00:14, H. Peter Anvin wrote:
> Followup to:  <20020715220241Z317668-685+9887@vger.kernel.org>
> By author:    Rudmer van Dijk <rvandijk@science.uva.nl>
> In newsgroup: linux.dev.kernel
> >
> > On Monday 15 July 2002 23:48, Alan Cox wrote:
> > > Linux 2.4.19rc1-ac5
> > 
> > it looks like the file is damaged:
> > 
> > # gzip -t patch-2.4.19-rc1-ac5.gz
> > gzip: patch-2.4.19-rc1-ac5.gz: invalid compressed data--format violated
> > 
> > waiting for the .bz2 file...
> > 
> 
> The file on zeus.kernel.org is just fine.  Problem is on your end.

I fixed the file on zeus - it was originally wrong.

