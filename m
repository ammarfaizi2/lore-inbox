Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTLBQ2h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 11:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbTLBQ2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 11:28:37 -0500
Received: from havoc.gtf.org ([63.247.75.124]:13457 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262288AbTLBQ2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 11:28:35 -0500
Date: Tue, 2 Dec 2003 11:28:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Darrell Michaud <dmichaud@wsi.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Russell Cattelan <cattelan@xfs.org>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: XFS for 2.4
Message-ID: <20031202162808.GC22608@gtf.org>
References: <Pine.LNX.4.44.0312021346530.13692-100000@logos.cnet> <1070381443.5316.260.camel@atherne>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070381443.5316.260.camel@atherne>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 11:10:43AM -0500, Darrell Michaud wrote:
> As a user it would be very beneficial for me to have XFS support in the
> official 2.4 kernel tree. XFS been stable and "2.4 integration-ready"
> for a long time, and 2.4 is going to be used in certain environments for
> a long time, if only because it's easier to upgrade a 2.4 kernel to a
> newer 2.4 kernel than to upgrade to a 2.6 kernel. It seems like an easy
> case to make.
> 
> I use other filesystems and some funky drivers as well.. and I'm always
> very happy to see useful backports show up in the 2.4 tree. Thank you!

This can also be done in patch form, as it is done now :)

There are several pieces of backported software that are
integration-ready, but that doesn't imply they should go into an
increasingly-frozen 2.4.x tree...

	Jeff



