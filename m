Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317687AbSGOXLj>; Mon, 15 Jul 2002 19:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317688AbSGOXLi>; Mon, 15 Jul 2002 19:11:38 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2066 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317687AbSGOXLi>; Mon, 15 Jul 2002 19:11:38 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux 2.4.19-rc1-ac5
Date: 15 Jul 2002 16:14:08 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <agvl00$jjm$1@cesium.transmeta.com>
References: <200207152148.g6FLm7Q24750@devserv.devel.redhat.com> <20020715220241Z317668-685+9887@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020715220241Z317668-685+9887@vger.kernel.org>
By author:    Rudmer van Dijk <rvandijk@science.uva.nl>
In newsgroup: linux.dev.kernel
>
> On Monday 15 July 2002 23:48, Alan Cox wrote:
> > Linux 2.4.19rc1-ac5
> 
> it looks like the file is damaged:
> 
> # gzip -t patch-2.4.19-rc1-ac5.gz
> gzip: patch-2.4.19-rc1-ac5.gz: invalid compressed data--format violated
> 
> waiting for the .bz2 file...
> 

The file on zeus.kernel.org is just fine.  Problem is on your end.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
