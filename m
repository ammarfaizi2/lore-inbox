Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbULMOTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbULMOTr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 09:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbULMOTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 09:19:47 -0500
Received: from sweep.bur.st ([202.61.227.58]:24335 "EHLO stutter.bur.st")
	by vger.kernel.org with ESMTP id S261211AbULMOTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 09:19:45 -0500
Date: Mon, 13 Dec 2004 22:19:44 +0800
From: Trent Lloyd <lathiat@bur.st>
To: Ravi Kumar <ravivsn@rocsys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Load Balancing
Message-ID: <20041213141944.GA19702@sweep.bur.st>
References: <41BDA86F.8070108@rocsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BDA86F.8070108@rocsys.com>
X-Random-Number: -2.06381333147424e-302
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You might want to look at LVS 'Linux Virtual Server' and related
projects, I can't recall the sites offhand but theres stuff linked from
www.ultramonkey.org

Cheers,
Trent

On Mon, Dec 13, 2004 at 08:04:23PM +0530, Ravi Kumar wrote:
> Hi,
>  After going thro Linux Advanced Routing Howto, I understand 
> Loadbalancing is done but not so effective, the Howto gave a link for 
> patch but unfortunately I am not able to locate a patch for 2.4.18-14 
> kernel version.
> 
> Can you provide me pointers/links for a effective load balancing in 
> linux-2.4.18 kernel.
> 
> Thanks,
> -Ravi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Trent Lloyd <lathiat@bur.st>
Bur.st Networking Inc.
