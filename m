Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267383AbTAHNB6>; Wed, 8 Jan 2003 08:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267393AbTAHNB6>; Wed, 8 Jan 2003 08:01:58 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54665
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267383AbTAHNB5>; Wed, 8 Jan 2003 08:01:57 -0500
Subject: Re: Question for Marcelo
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Samuel Flory <sflory@rackable.com>
Cc: Walt H <waltabbyh@mindspring.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E1B8E2B.9060200@rackable.com>
References: <3E1AFA70.4070200@mindspring.com>
	 <3E1B8E2B.9060200@rackable.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042034152.24099.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 08 Jan 2003 13:55:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-08 at 02:34, Samuel Flory wrote:
>   I believe that he would prefer that it get tested in the ac tree 1st. 
>  Alan seemed receptive to including it, but he's not doing much with the 
> 2.4 ac kernel any more.
> 

I've been working on merging a lot of stuff with Marcelo and cleaning up the
other changes. 2.4.21pre-ac should be out today, and its a lot smaller than
before as Marcelo as almost all the apic stuff, IDE updates etc. I've also
dropped rmap out for now

