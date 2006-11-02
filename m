Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWKBGND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWKBGND (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 01:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbWKBGND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 01:13:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:19144 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751469AbWKBGNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 01:13:01 -0500
Date: Wed, 1 Nov 2006 22:01:39 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc4-mm1
Message-ID: <20061102060139.GA11168@kroah.com>
References: <20061031015121.dfc7e02a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031015121.dfc7e02a.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 01:51:21AM -0800, Andrew Morton wrote:
> - 2.6.19-rc3-mm1 was rather a mess.  This is mainly an attempt to repair it.

I think most of this was my fault, so I'll take the blame here...

> - The driver tree has been dropped due to various problems.  Consequently a
>   string of patches which are destined for the driver tree have also been
>   temporarily removed.  Various other patches have been set aside, rejects
>   have been fixed up, etc.  Dropping trees is a pain.

I have fixed up (hopefully) all of these issues now, so feel free to
pull my trees in into the next -mm release.

thanks,

greg k-h
