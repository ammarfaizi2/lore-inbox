Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030545AbWCTWDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030545AbWCTWDm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030541AbWCTWDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:03:25 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:33210
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030545AbWCTWC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:02:58 -0500
Date: Mon, 20 Mar 2006 14:02:43 -0800
From: Greg KH <gregkh@suse.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.16
Message-ID: <20060320220243.GA1760@suse.de>
References: <20060320212338.GA11571@kroah.com> <20060320133230.ae739f58.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320133230.ae739f58.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 01:32:30PM -0800, Randy.Dunlap wrote:
> More Documentation/ references to /devfs/i :
> 
> Changes
> computone.txt
> feature-removal-schedule.txt
> initrd.txt
> ioctl-number.txt
> kernel-docs.txt
> kernel-parameters.txt
> README.DAC960

Yes, some of the surrounding documentation might still need to be
cleaned up.  I'll do that in a few days (after I push out my other
trees...)

thanks,

greg k-h
