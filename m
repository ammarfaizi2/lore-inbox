Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbTKYRVG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbTKYRVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:21:05 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:62986 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262787AbTKYRVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:21:03 -0500
Date: Tue, 25 Nov 2003 17:20:59 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Joe Thornber <thornber@sistina.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Patch 3/5] dm: make v4 of the ioctl interface the default
Message-ID: <20031125172059.A22743@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Joe Thornber <thornber@sistina.com>,
	Linux Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>
References: <20031125162451.GA524@reti> <20031125163313.GD524@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031125163313.GD524@reti>; from thornber@sistina.com on Tue, Nov 25, 2003 at 04:33:13PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 04:33:13PM +0000, Joe Thornber wrote:
> Make the version-4 ioctl interface the default kernel configuration option.
> If you have out of date tools you will need to use the v1 interface.

So why do we keep the old version at all?

