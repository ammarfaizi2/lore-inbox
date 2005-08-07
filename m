Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVHGBJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVHGBJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 21:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVHGBJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 21:09:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50644 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261407AbVHGBJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 21:09:18 -0400
Date: Sat, 6 Aug 2005 18:09:08 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, hpa@zytor.com, Riley@Williams.Name,
       pratap@vmware.com, chrisl@vmware.com
Subject: Re: [PATCH] 4/8 Move TLB flush definitions to the sub-architecture level
Message-ID: <20050807010908.GI7762@shell0.pdx.osdl.net>
References: <42F4639A.7090304@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F4639A.7090304@vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> i386 Transparent Paravirtualization Patch #4
> 
> This change encapsulates TLB flush accessors into the sub-architecture layer.

Hrm, same here (pushed too much to subarch), so I'll update that one
and report back tomorrow.

thanks,
-chris
