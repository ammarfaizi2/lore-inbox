Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVIGLcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVIGLcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 07:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVIGLcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 07:32:50 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:7688 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932114AbVIGLct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 07:32:49 -0400
Date: Wed, 7 Sep 2005 07:32:24 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernel profiles anyone?
Message-ID: <20050907113224.GA13878@hmsreliant.homelinux.net>
References: <431E43C8.3030309@comcast.net> <1126067216.13159.44.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126067216.13159.44.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 12:26:55AM -0400, Lee Revell wrote:
> On Tue, 2005-09-06 at 21:35 -0400, John Richard Moser wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > Are there any recent kernel profiles?  I think from an acedemic
> > perspective it'd be nice to see some graphs and numbers nobody
> > understands showing where the longest running code paths in the kernel
> > occur.  It might also be nice for those latency whores (*runs to the
> > back and raises hand*) and those who want to increase overall
> > performance and efficiency; then there'd be a map showing . . .
> > something that only kernel hackers could possibly understand or care about.
> 
oprofile is designed to do exactly this.  just set it up and run the workload
you are interested in.

Regards
Neil


-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
