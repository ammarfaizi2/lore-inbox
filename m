Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbSLMVeG>; Fri, 13 Dec 2002 16:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbSLMVeG>; Fri, 13 Dec 2002 16:34:06 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:26031 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S265457AbSLMVeF>;
	Fri, 13 Dec 2002 16:34:05 -0500
Date: Fri, 13 Dec 2002 23:55:21 -0500
From: Christoph Hellwig <hch@sgi.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Message-ID: <20021213235521.A8607@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
References: <20021213180814.A2658@sgi.com> <20021213213458.GG4817@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021213213458.GG4817@fs.tum.de>; from bunk@fs.tum.de on Fri, Dec 13, 2002 at 10:34:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2002 at 10:34:59PM +0100, Adrian Bunk wrote:
> On Fri, Dec 13, 2002 at 06:08:14PM -0500, Christoph Hellwig wrote:
> 
> >...
> > now that all vendors ship a backport of Ingo's O(1) scheduler, external
> >...
> 
> #include <all-vendors-except-Debian>  ;-)

OOPS, I reused the first template again.  I think I owe you a beer :)

