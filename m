Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316764AbSE3RJh>; Thu, 30 May 2002 13:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316765AbSE3RJg>; Thu, 30 May 2002 13:09:36 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:42245 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316764AbSE3RJg>; Thu, 30 May 2002 13:09:36 -0400
Date: Thu, 30 May 2002 19:09:21 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre9-ac1
Message-ID: <20020530170921.GF7078@louise.pinerecords.com>
In-Reply-To: <200205301311.g4UDBlY21108@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: GNU/Linux 2.4.19-pre9/sparc SMP
X-Uptime: 20:04
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So what's the secret behind -pre9-ac2? :)

T.

> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out]
> 
> Linux 2.4.19pre9-ac1
> o	Merge with 2.4.19pre9
> o	Fix SuS violation on readv/writev		(me)
> 	| I believe this one is correct, please double check
> ...
