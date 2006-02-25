Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWBYCIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWBYCIF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 21:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWBYCIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 21:08:04 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37507 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S964850AbWBYCIC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 21:08:02 -0500
Date: Fri, 24 Feb 2006 18:10:09 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: stable@kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [stable] [PATCH 1/2] sd: fix memory corruption by sd_read_cache_type
Message-ID: <20060225021009.GV3883@sorel.sous-sol.org>
References: <tkrat.014f03dc41356221@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tkrat.014f03dc41356221@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stefan Richter (stefanr@s5r6.in-berlin.de) wrote:
> sd: fix memory corruption by sd_read_cache_type

Looks like these still aren't upstream.  Can you please resend to -stable
once they've been picked up by Linus?

thanks,
-chris
