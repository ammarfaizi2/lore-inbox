Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWDDC7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWDDC7T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 22:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWDDC7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 22:59:19 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:18124
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S964979AbWDDC7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 22:59:19 -0400
Date: Mon, 3 Apr 2006 19:58:18 -0700
From: Greg KH <gregkh@suse.de>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: Karsten Keil <kkeil@suse.de>, i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Tilman Schmidt <tilman@imap.cc>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/13] isdn4linux: Siemens Gigaset drivers update
Message-ID: <20060404025818.GA12076@suse.de>
References: <gigaset307x.2006.04.04.001.0@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.04.04.001.0@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 02:00:24AM +0200, Hansjoerg Lipp wrote:
> The following series of patches contains updates to the Siemens Gigaset
> drivers suggested by various reviewers on lkml. These should go into
> 2.6.17 if at all possible. Please apply in order.

Hm, the big merge window for 2.6.17 is past.  If this is a
single-driver-only update, it might be argued that this should be
accepted into 2.6.17, but only after it has had a few weeks of testing
in -mm.  After a few weeks being in -mm however, it will be too late to
go into 2.6.17.

So, is 2.6.18 ok?

thanks,

greg k-h
