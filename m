Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbUCAICU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 03:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbUCAICU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 03:02:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16545 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262266AbUCAICT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 03:02:19 -0500
Date: Mon, 1 Mar 2004 09:02:07 +0100
From: Jens Axboe <axboe@suse.de>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Greg KH <greg@kroah.com>, Daniel Robbins <drobbins@gentoo.org>,
       linux-kernel@vger.kernel.org, Mike@kordik.net,
       kpfleming@backtobasicsmgmt.com
Subject: Re: [PATCH] Re: 2.6.3-bk9 QA testing: firewire good, USB printing dead
Message-ID: <20040301080207.GA9196@suse.de>
References: <1077933682.14653.23.camel@wave.gentoo.org> <20040228021040.GA14836@kroah.com> <20040229095139.GH3149@suse.de> <20040301074348.GA7646@ip68-4-255-84.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040301074348.GA7646@ip68-4-255-84.oc.oc.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 29 2004, Barry K. Nathan wrote:
> Does this patch (following my signature) fix the printer hangs?
> (It does for me.)
> 
> BTW, it's also an attachment on OSDL bugzilla #2221:
> http://bugme.osdl.org/show_bug.cgi?id=2221

Works for me, thanks (applied on top of 2.6.4-rc1-mm1)

-- 
Jens Axboe

