Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbVD2EXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVD2EXr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 00:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262387AbVD2EXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 00:23:47 -0400
Received: from smtp.istop.com ([66.11.167.126]:23242 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262385AbVD2EXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 00:23:30 -0400
From: Daniel Phillips <phillips@istop.com>
To: David Teigland <teigland@redhat.com>
Subject: Re: [PATCH 0/7] dlm: overview
Date: Fri, 29 Apr 2005 00:24:07 -0400
User-Agent: KMail/1.7
Cc: Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org
References: <20050425151136.GA6826@redhat.com> <20050427135635.GA4431@marowsky-bree.de> <20050428162552.GH10628@redhat.com>
In-Reply-To: <20050428162552.GH10628@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504290024.08076.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 April 2005 12:25, David Teigland wrote:
> There's a dlm daemon in user space that works with the specific sysfs
> files above and interfaces with whatever cluster infrastructure exists.
> The same goes for gfs, but the gfs user space daemon does quite a lot more
> (gfs-specific stuff).
>
> In other words, these aren't external API's; they're internal interfaces
> within systems that happen to be split between the kernel and user-space.

Traditionally, Linux kernel interfaces have been well-defined.  I do not think 
we want to break with that tradition now.

So please provide a pointer to the kernel interface you have in mind.

Regards,

Daniel
