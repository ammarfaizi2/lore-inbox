Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263220AbUKUDXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263220AbUKUDXL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 22:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbUKUDXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 22:23:11 -0500
Received: from stutter.bur.st ([202.61.227.61]:49954 "EHLO stutter.bur.st")
	by vger.kernel.org with ESMTP id S263208AbUKUDVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 22:21:51 -0500
Date: Sun, 21 Nov 2004 11:21:48 +0800
From: Trent Lloyd <lathiat@bur.st>
To: cranium2003 <cranium2003@yahoo.com>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: can netfilter help me.....
Message-ID: <20041121032148.GA19274@sweep.bur.st>
References: <20041121031849.95509.qmail@web41415.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041121031849.95509.qmail@web41415.mail.yahoo.com>
X-Random-Number: -1.04485277695876e-42
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cranium,

There is the possibility to use some userspace magic and queue packets
via it, and I assume you can probably modify those packets. I assume
theres some docs on the netfilter website.

Cheers,
Trent
Bur.st

> hello,
>        For adding new header in packet, can it be
> possible for me to use netfilter to add my own header
> in between ip and ethernet header? 
> can anybody please help to how can i use netfilter
> hooks to add new header?
> can netfilter also allow me to change its
> identification as ETH_IP to ETH_MY_IP?
> regrads,
> cranium.
> 
> 
> 		
> __________________________________ 
> Do you Yahoo!? 
> Meet the all-new My Yahoo! - Try it today! 
> http://my.yahoo.com 
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Trent Lloyd <lathiat@bur.st>
Bur.st Networking Inc.
