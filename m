Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316725AbSEQXOv>; Fri, 17 May 2002 19:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316726AbSEQXOu>; Fri, 17 May 2002 19:14:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19212 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316725AbSEQXOt>; Fri, 17 May 2002 19:14:49 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Aralion and IDE blasphemy
Date: 17 May 2002 16:14:30 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ac42sm$qo0$1@cesium.transmeta.com>
In-Reply-To: <20020517142617.5b73a46d.jpm@it-he.org> <E178iAB-0006Xu-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E178iAB-0006Xu-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> > This is probably approaching blasphemy, but has anyone ever considered
> > an emergency EIDE driver that uses the extended int13h calls?
> 
> Its not worth the pain. It was done by Adam J Richter before 1.0 in
> fact and is long dead
> 

Well, it was done by Ross Biro, who was working for Adam at the
time...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
