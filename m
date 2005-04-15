Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVDOSAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVDOSAy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 14:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVDOSAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 14:00:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:22987 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261869AbVDOSAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 14:00:51 -0400
Date: Fri, 15 Apr 2005 11:00:48 -0700
From: Chris Wright <chrisw@osdl.org>
To: Linda Luu <linda.luu@comcast.net>
Cc: linux-kernel@vger.kernel.org,
       "Nguyen, Nguyen (Home)" <ndnguyen3@comcast.net>
Subject: Re: Multi-core, Vanderpool support?
Message-ID: <20050415180048.GC23013@shell0.pdx.osdl.net>
References: <004901c541d9$16b18ad0$6501a8c0@Jaguar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004901c541d9$16b18ad0$6501a8c0@Jaguar>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linda Luu (linda.luu@comcast.net) wrote:
> Vanderpool is a hardware support for OS virtualization (running multiple OS
> "at the same time"), how does Linux kernel make use of this, particularly
> which part of the kernel code? 

There's Xen support for upcoming VT, which will allow running unmodified
guest.

thanks,
-chris
