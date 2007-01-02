Return-Path: <linux-kernel-owner+w=401wt.eu-S1753438AbXABSPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbXABSPz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 13:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753651AbXABSPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 13:15:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35565 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438AbXABSPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 13:15:54 -0500
Date: Tue, 2 Jan 2007 13:15:43 -0500
From: Dave Jones <davej@redhat.com>
To: Theodore Tso <tytso@mit.edu>, Alan <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Print sysrq-m messages with KERN_INFO priority
Message-ID: <20070102181543.GF7656@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Theodore Tso <tytso@mit.edu>, Alan <alan@lxorguk.ukuu.org.uk>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <E1H0Uq5-0003Fo-1W@candygram.thunk.org> <20061229204247.be66c972.akpm@osdl.org> <20070102043743.GB15718@thunk.org> <20070102103332.46de83bd@localhost.localdomain> <20070102180354.GA892@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070102180354.GA892@thunk.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 01:03:54PM -0500, Theodore Tso wrote:

 > or perhaps better, making the sysrq-m information
 > available via either /proc or /sys?

or debugfs ?

		Dave


-- 
http://www.codemonkey.org.uk
