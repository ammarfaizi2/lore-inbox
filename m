Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317628AbSFRVaL>; Tue, 18 Jun 2002 17:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317629AbSFRVaK>; Tue, 18 Jun 2002 17:30:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33037 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317628AbSFRVaJ>; Tue, 18 Jun 2002 17:30:09 -0400
Date: Tue, 18 Jun 2002 22:30:08 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: zaimi@pegasus.rutgers.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel upgrade on the fly
Message-ID: <20020618223008.A17795@flint.arm.linux.org.uk>
References: <Pine.GSO.4.44.0206181703540.26846-100000@pegasus.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.44.0206181703540.26846-100000@pegasus.rutgers.edu>; from zaimi@pegasus.rutgers.edu on Tue, Jun 18, 2002 at 05:21:49PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 05:21:49PM -0400, zaimi@pegasus.rutgers.edu wrote:
>  has anybody worked or thought about a property to upgrade the kernel
> while the system is running?  ie. with all processes waiting in their
> queues while the resident-older kernel gets replaced by a newer one.

This has been discussed over and over and over and over and over and over
and over and over and over and over and over and over and over and over
here; typically it comes up about once every six months.  Please see
the FAQ: http://www.tux.org/lkml or alternatively search the lkml
archives.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

