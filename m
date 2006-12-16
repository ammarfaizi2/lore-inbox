Return-Path: <linux-kernel-owner+w=401wt.eu-S1161148AbWLPQ3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbWLPQ3e (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 11:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161150AbWLPQ3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 11:29:34 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:34720 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161148AbWLPQ3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 11:29:33 -0500
Message-ID: <45841EE0.8020807@pobox.com>
Date: Sat, 16 Dec 2006 11:29:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Alan <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pata_via: Cable detect error
References: <20061216143221.47c5e7f3@localhost.localdomain> <45841525.7040406@pobox.com> <20061216161647.GG23368@redhat.com>
In-Reply-To: <20061216161647.GG23368@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Sat, Dec 16, 2006 at 10:47:49AM -0500, Jeff Garzik wrote:
> 
>  > I think it's #upstream-fixes material (-rc material), and applied as such.
>  > 
>  > Especially considering that libata pata_* drivers are not the primary 
>  > drivers, I think it's best to forward this type of stuff, especially as 
>  > it is indeed IMO a fix worth having.
> 
> They may not be primary today, but it's not going to be very long
> at all before that situation changes.  AFAIK, most of (if not all) the major
> distros basing on 2.6.19+ are moving to using the libata PATA drivers in
> their next releases.

All the more reason to get fixes in as quickly as possible, to ensure 
maximal amount of testing and exposure :)

	Jeff



