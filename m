Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264932AbUD2T3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264932AbUD2T3X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 15:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264934AbUD2T3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 15:29:23 -0400
Received: from verein.lst.de ([212.34.189.10]:16107 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S264932AbUD2T3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 15:29:21 -0400
Date: Thu, 29 Apr 2004 21:29:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paul Jackson <pj@sgi.com>
Cc: erikj@subway.americas.sgi.com, chrisw@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
Message-ID: <20040429192909.GA29725@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, Paul Jackson <pj@sgi.com>,
	erikj@subway.americas.sgi.com, chrisw@osdl.org,
	linux-kernel@vger.kernel.org
References: <Pine.SGI.4.53.0404261656230.591647@subway.americas.sgi.com> <20040426163955.X21045@build.pdx.osdl.net> <Pine.SGI.4.53.0404271546410.632984@subway.americas.sgi.com> <20040428145503.GA999@lst.de> <20040429122026.2ad7884e.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429122026.2ad7884e.pj@sgi.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 12:20:26PM -0700, Paul Jackson wrote:
> >  - without any user merging doesn't make sense
> 
> Could you try restating this particular comment, Christoph?
> I am failing to make any sense of it.

without merging anything that actually uses pagg getting pagg itself
into the kernel doesn't make a lot of sense.
