Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319273AbSHVB0G>; Wed, 21 Aug 2002 21:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319274AbSHVB0G>; Wed, 21 Aug 2002 21:26:06 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:30215
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319273AbSHVB0G>; Wed, 21 Aug 2002 21:26:06 -0400
Date: Wed, 21 Aug 2002 18:29:35 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Erik Andersen <andersen@codepoet.org>
cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac6
In-Reply-To: <20020822011839.GA28136@codepoet.org>
Message-ID: <Pine.LNX.4.10.10208211828570.10353-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Erm Alan, what happened boss ?

Lemme resend that jewel.

On Wed, 21 Aug 2002, Erik Andersen wrote:

> On Wed Aug 21, 2002 at 06:07:42PM -0700, Andre Hedrick wrote:
> > 
> > Erm were did it get lost then ?
> 
> dunno.  linux.20pre2-ac6/drivers/ide/Config.in has
>     +   dep_mbool '    Reduce media failure retries support' \
> 	    CONFIG_BLK_DEV_IDECD_BAILOUT $CONFIG_BLK_DEV_IDECD
> but no code uses it...  So I figured I'd mention it,
> 
>  -Erik
> 
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--
> 

Andre Hedrick
LAD Storage Consulting Group

