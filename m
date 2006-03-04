Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWCDLW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWCDLW3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 06:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWCDLW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 06:22:29 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:36057 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751326AbWCDLW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 06:22:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=NKpYNrcWTLr+bf24W+Epge32jbj37Hu6TV9Gz8LeZUDyMUFc+3723fuPYdy+wWLb7gO0paSw24lk30vO8D4oZ+g5c6X/g65pDyI42Ya7xfGsUzOLZiEo+o8mBWmJWcN7opnvU7YATNB5nNoyfK+TXH2a+Ovogmv+AKPjG4tq8b0=
Date: Sat, 4 Mar 2006 14:22:21 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 7/8] [I/OAT] Add a sysctl for tuning the I/OAT offloaded I/O threshold
Message-ID: <20060304112221.GA7790@mipter.zuzino.mipt.ru>
References: <20060303214036.11908.10499.stgit@gitlost.site> <20060303214234.11908.99495.stgit@gitlost.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303214234.11908.99495.stgit@gitlost.site>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 01:42:34PM -0800, Chris Leech wrote:
> Any socket recv of less than this ammount will not be offloaded

There is no documentation update.

