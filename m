Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWCCPQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWCCPQk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 10:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWCCPQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 10:16:40 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58117 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751480AbWCCPQi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 10:16:38 -0500
Date: Fri, 3 Mar 2006 15:09:08 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Koen Martens <linuxarm@metro.cx>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/14] s3c2412/s3c2413 support
Message-ID: <20060303150908.GA2580@ucw.cz>
References: <44082001.9090308@metro.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44082001.9090308@metro.cx>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 03-03-06 11:52:49, Koen Martens wrote:
> This patchset adds various defines and bits for the 
> s3c2412 and s3c2413
> processors, as well as adding detection of this cpu to 
> platform setup and
> uncompress boot stage.
> The changes should not disturb current s3c24xx 
> implementations. The
> patchset is preliminary, in that the final datasheet is 
> not yet available. We
> did some testing of these new registers and bits outside 
> of the linux
> kernel.

Could you

a) describe what kind of beast these CPUs are

and perhaps

b) invent some better name for architecture? What you have seems like
password of *very* paranoid sysadmin.
							Pavel
-- 
Thanks, Sharp!
