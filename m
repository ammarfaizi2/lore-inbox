Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311664AbSC1GO3>; Thu, 28 Mar 2002 01:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311735AbSC1GOT>; Thu, 28 Mar 2002 01:14:19 -0500
Received: from zok.SGI.COM ([204.94.215.101]:28074 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S311664AbSC1GOH>;
	Thu, 28 Mar 2002 01:14:07 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Daniel E. Shipton" <dshipton@vrac.iastate.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ne2k-pci module for EZCARD10 i.e SMC1208T --connections dying out 
In-Reply-To: Your message of "27 Mar 2002 10:53:25 MDT."
             <1017248005.10060.4.camel@regatta> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Mar 2002 17:13:58 +1100
Message-ID: <22514.1017296038@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Mar 2002 10:53:25 -0600, 
"Daniel E. Shipton" <dshipton@vrac.iastate.edu> wrote:
>I have a computer that on most web sites, ftp transfers or anything
>related to the network
>will start a connection and atart transferring for about 2 seconds and
>then the connection
>will die out.  This does not happen on all sites but with most.  When
>booted into windows it has
>no problem.

ifconfig eth0 mtu 528

If that works, read
http://groups.google.com/groups?hl=en&threadm=linux.kernel.1750.961061901%40ocs3.ocs-net&rnum=2

