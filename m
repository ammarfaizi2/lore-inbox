Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSGQTE2>; Wed, 17 Jul 2002 15:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316322AbSGQTE2>; Wed, 17 Jul 2002 15:04:28 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:17147 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316309AbSGQTE2>; Wed, 17 Jul 2002 15:04:28 -0400
Subject: Re: 2.4.19rc2 and Promise RAID controller
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Klaus Dittrich <kladit@t-online.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10207170950050.10225-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10207170950050.10225-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Jul 2002 21:17:09 +0100
Message-Id: <1026937029.1688.160.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-17 at 17:54, Andre Hedrick wrote:
> 
> This is just proves that accepting the patch code from Promise will begin
> to remove basic support for hardware.  I warned everyone of this and
> people do not listen.  So I suggest that you find another vendors product
> to use as the PDC20270 shall not be supported anymore.

Andre, this is not the case. We all agreed to sort out the raid detect. 
I sent Marcelo a diff and some instructions. He applied the diff but I
guess my instructions were too confusing. It'll get fixed for -rc3

If you want a conspiracy to play with look elsewhere (there are no
shortage of real ones 8))

