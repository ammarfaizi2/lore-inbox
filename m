Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSFTImt>; Thu, 20 Jun 2002 04:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSFTIms>; Thu, 20 Jun 2002 04:42:48 -0400
Received: from angband.namesys.com ([212.16.7.85]:9600 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S312254AbSFTIms>; Thu, 20 Jun 2002 04:42:48 -0400
Date: Thu, 20 Jun 2002 12:42:46 +0400
From: Oleg Drokin <green@namesys.com>
To: Nils =?koi8-r?Q?O=2E_=3D=3FISO-8859-1=3FQ=3FSel=3DE5sdal?= ?= 
	<noselasd@Utel.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS & NFS oops
Message-ID: <20020620124246.A1020@namesys.com>
References: <200206181041.g5IAfpL20399@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200206181041.g5IAfpL20399@localhost.localdomain>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Can you reproduce this?

Bye,
    Oleg
On Tue, Jun 18, 2002 at 12:41:51PM +0200, Nils O. =?ISO-8859-1?Q?Sel=E5sdal ?= wrote:
> Just wanted to know if this is a known problem and if it might be fixed in
> the near future:
> Using 2.4.19-pre8 just one filesystem with reiserfs, I exported a directory. Mounted
> it on another hosts and started writing a large (500mb) file to it, that resulted
> in the server filesystem going full and the server locked up hard.
> 
> -
> NOS@Utel.no
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
