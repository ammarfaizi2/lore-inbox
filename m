Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269104AbUJESDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269104AbUJESDb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 14:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269092AbUJESDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 14:03:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9116 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269127AbUJESD2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 14:03:28 -0400
Date: Tue, 5 Oct 2004 09:55:39 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Shlomi Yaakobovich <Shlomi@exanet.com>, acme@conectiva.com.br
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: (as189) Fix incorrect Appletalk DDP multicast address
Message-ID: <20041005125539.GB2000@logos.cnet>
References: <F8B4823728281C429F53D71695A3AA1E012729B1@hawk.exanet-il.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F8B4823728281C429F53D71695A3AA1E012729B1@hawk.exanet-il.co.il>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Arnaldo, 

Can you take care of this for us?


On Sun, Oct 03, 2004 at 09:50:44AM +0200, Shlomi Yaakobovich wrote:
> Hi all,
> 
> Does anyone know what happened to the patch proposed by Alan Stern:
> 
> 	http://www.ussg.iu.edu/hypermail/linux/kernel/0402.1/1147.html
> 
> I looked at the latest sources of 2.4 and 2.6 and this patch was not applied to them. Was there a specific reason, was this patch not tested or found buggy ?  
> I believe I have encountered a bug in the system I'm running that is related to this, I found this by accident when debugging appletalk, and found out that someone already 
>saw this...
> 
> Can this patch be applied to the next kernel build ?  I noticed that it was only for 2.6, I can create a similar patch for 2.4 if needed, I just need to know if there was something wrong with it.
