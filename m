Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSEUCm0>; Mon, 20 May 2002 22:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316492AbSEUCmZ>; Mon, 20 May 2002 22:42:25 -0400
Received: from ns0.auctionwatch.com ([66.7.130.2]:47373 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id <S316491AbSEUCmZ>; Mon, 20 May 2002 22:42:25 -0400
Date: Mon, 20 May 2002 19:42:25 -0700
From: Petro <petro@auctionwatch.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Just an offer
Message-ID: <20020521024225.GG20766@auctionwatch.com>
In-Reply-To: <20020517122946.18213.qmail@bilmuh.ege.edu.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 12:29:46PM -0000, Halil Demirezen wrote:
> 
> I wonder if there is a way of making the kernel decide whether it can boot 
> successfully or not. For example, lets think of that i am compiling an 
> update kernel not on the local machine but on any other pc using telnet or 
> ssh emulators. And eventually it is time to reboot the machine and and run 
> on the new kernel. However there has been an error during the compiling. - 
> such as misconfiguration. Normally the machine will not boot and halt. So, 
> is not there any way to reboot itself from the previous kernel after some 
> time that it realizes it cannot boot properly. Maybe there is such a way. 
> But, if not, this is an imaginary. Because i usually see these kind of 
> problems ;)

    (1) Serial console is your buddy. 

    (2) Remote power switches save your butt: 
    http://www.apc.com/resource/include/techspec_index.cfm?base_sku=
    AP9211&language=en&LOCAL.APCCountryCode=us

    There is only so much software can do. 
    

-- 
My last cigarette was roughly 28 days, 17 hours, 11 minutes ago.
YHBW
