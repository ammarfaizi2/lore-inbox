Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263180AbTHVSAh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 14:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbTHVSAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 14:00:37 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:51464
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263190AbTHVSAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 14:00:36 -0400
Date: Fri, 22 Aug 2003 11:00:30 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: John Bradford <john@grabjohn.com>
Cc: hch@lst.de, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix the -test3 input config damages
Message-ID: <20030822180030.GI1040@matchmail.com>
Mail-Followup-To: John Bradford <john@grabjohn.com>, hch@lst.de,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <200308221757.h7MHv3uS000585@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308221757.h7MHv3uS000585@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 06:57:03PM +0100, John Bradford wrote:
> > Is it worth it? I see EMBEDDED as more of a "STANDARD" thing - for people
> > who don't care or know, that's a slight safety-net saying "this selects
> > the things you take for grated".
> 
> I'm pretty sure that's not what it was originally intended to be, but
> rather what it seems to have become.  On the other hand, your
> described usage is probably more useful to the typical user.
> 
> Why not have DEVELOPER to implement the original intentions of
> EMBEDDED?

I think I like CONFIG_NONSTD_ABI better.
