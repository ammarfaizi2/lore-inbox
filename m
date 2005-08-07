Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVHGBNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVHGBNm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 21:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVHGBL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 21:11:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14037 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261410AbVHGBLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 21:11:46 -0400
Date: Sat, 6 Aug 2005 18:11:28 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, hpa@zytor.com, Riley@Williams.Name,
       pratap@vmware.com, chrisl@vmware.com
Subject: Re: [PATCH] 6/8 Move sensitive I/O instructions into the sub-arch layer
Message-ID: <20050807011128.GK7762@shell0.pdx.osdl.net>
References: <42F464AE.80507@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F464AE.80507@vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Move I/O instructions into the sub-arch layer where they can be overridden.

As I already mentioned, this one needs refactoring on my side before I
can give a review...tomorrow...

thanks,
-chris
