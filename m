Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVCIVfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVCIVfw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVCIVaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 16:30:01 -0500
Received: from fire.osdl.org ([65.172.181.4]:63187 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262449AbVCIV1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 16:27:20 -0500
Message-ID: <422F6A2F.6080306@osdl.org>
Date: Wed, 09 Mar 2005 13:27:11 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: DHollenbeck <dick@softplc.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x.y gatekeeper discipline
References: <422F66C6.50208@softplc.com>
In-Reply-To: <422F66C6.50208@softplc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DHollenbeck wrote:
> I had hoped that the proper discipline in rejecting non-critical patches 
> would have pertained.  I remain unconvinced that the .y releases are 
> anything but noise that should have been kept elsewhere.  After reading 
> through a patch summary, I see this as typical:
> 
> 
> ----------------------
> 
> 
>      ChangeSet 2005/02/22 20:56:28-05:00, bunk @ stusta.de
>      
> <http://kernel.org/pub/linux/kernel/v2.6/testing/cset/cset-bunk@stusta.de%5Bjgarzik%5D%7CChangeSet%7C20050223015628%7C49266.txt> 
> 
>      [diffview]
>      
> <http://www.kernel.org/diff/diffview.cgi?file=/pub/linux/kernel/v2.5/testing/cset/cset-bunk@stusta.de%5Bjgarzik%5D%7CChangeSet%7C20050223015628%7C49266.txt> 
> 
> 
> [PATCH] drivers/net/via-rhine.c: make a variable static const
> 
> This patch makes a needlessly global variable static const.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Signed-off-by: Jeff Garzik <jgarzik@pobox.com>
> 
> ----------------------------------
> 
> It's possible I simply don't get it, but the above description of a 
> patch hardly seems like it would qualify for the intentions of the 
> 2.6.x.y series.
> 
> Is this typical, and is this in line with the intent of the x.y series?
> 
> If this is going to achieve the objective, the gatekeeper has to be a 
> real stubborn, unpopular horse's ass it seems, with a sign on his 
> forehead that reads:  GO AWAY AND COME ANOTHER DAY!
> 
> Somewhat disappointedly,

Are you looking at 2.6.x.y patches?  I don't think so......

-- 
~Randy
