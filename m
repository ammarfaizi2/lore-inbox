Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWHFWAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWHFWAx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 18:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWHFWA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 18:00:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40973 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750732AbWHFWAG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 18:00:06 -0400
Date: Thu, 1 Jan 1970 00:15:22 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 7/8] Add a bootparameter to reserve high linear address space.
Message-ID: <19700101001522.GA3999@ucw.cz>
References: <20060803002510.634721860@xensource.com> <20060803002518.595166293@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803002518.595166293@xensource.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Add a bootparameter to reserve high linear address space for hypervisors.
> This is necessary to allow dynamically loaded hypervisor modules, which

Dynamically loaded hypervisor? Do we really want to support that?

							Pavel
-- 
Thanks for all the (sleeping) penguins.
