Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266243AbSKGAYF>; Wed, 6 Nov 2002 19:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266244AbSKGAYF>; Wed, 6 Nov 2002 19:24:05 -0500
Received: from pop015pub.verizon.net ([206.46.170.172]:7876 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S266243AbSKGAYE>; Wed, 6 Nov 2002 19:24:04 -0500
Message-Id: <200211070028.gA70SMDv000402@pool-141-150-241-241.delv.east.verizon.net>
Date: Wed, 6 Nov 2002 19:28:20 -0500
From: Skip Ford <skip.ford@verizon.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>, dcl_info@osdl.org,
       dcl_discussion@osdl.org, dev@osdl.org
Subject: Re: [ANNOUNCE] linux-2.5.46-dcl1
References: <1036626404.20740.169.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1036626404.20740.169.camel@dell_ss3.pdx.osdl.net>; from shemminger@osdl.org on Wed, Nov 06, 2002 at 03:46:44PM -0800
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop015.verizon.net from [141.150.241.241] at Wed, 6 Nov 2002 18:30:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> The latest release is available on SourceForge 
>    http://sourceforge.net/projects/osdldcl 
> 
> Linux 2.5.46-dcl1
>  * Update to Linux Trace Toolkit (LTT)		(Karim Yaghmour)

Why did you change the LTT syscall number for no good reason?  The tools
have to be recompiled to use it.  You could've left it 258 and just
added posix clocks after it.

-- 
Skip
