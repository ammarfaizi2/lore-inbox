Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVAZBoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVAZBoj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 20:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVAZBoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 20:44:39 -0500
Received: from v6.netlin.pl ([62.121.136.6]:33291 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262087AbVAZBoK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 20:44:10 -0500
Date: Wed, 26 Jan 2005 02:43:59 +0100
X-Mailer: JAW::Mail jawmail-2.0.1
X-Originating-IP: 83.29.65.178
Organization: K4 Labs
From: gj <gj@pointblue.com.pl>
To: =?UTF-8?B?UmVuw6kgUmViZQ==?= <rene@exactcode.de>
Subject: Re: swap is never used on ultrasparc64/32 - 2.6.11-rc2 (STILL NOT SOLVED)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <C7B3933A-6F2D-11D9-BA4F-000393AF911C@exactcode.de>
References: <41F65F1E.3070504@pointblue.com.pl> <41F68473.8080705@pointblue.com.pl> <C7B3933A-6F2D-11D9-BA4F-000393AF911C@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <20050126014400.052CB176@pointblue.com.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005 at 01:04:10, René Rebe wrote: 
 
> Hi, 
>  
> On 25. Jan 2005, at 18:40 Uhr, Grzegorz Piotr Jaskiewicz wrote: 
>  
> [...] 
>  
> I can confirm this. What is your last kernel that worked? I have no  
> data at hand - but I'm sure in either 2.6.8 or 2.6.10 swapping did  
> work. 
I've tried both 2.6.10 and 2.6.11-rc2. None of these works. I'll try earlier 
versions tommorow. Having very fast amd64 cross compilation computer helps in 
that a lot ;) 
 
--  
Grzegorz Jaskiewicz 
K4 Labs 
