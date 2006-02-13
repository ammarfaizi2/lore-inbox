Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWBMPOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWBMPOB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWBMPOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:14:00 -0500
Received: from kanga.kvack.org ([66.96.29.28]:25994 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932424AbWBMPOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:14:00 -0500
Date: Mon, 13 Feb 2006 10:09:11 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16-rc3
Message-ID: <20060213150911.GA22152@kvack.org>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <20060212190520.244fcaec.akpm@osdl.org> <1139800975.7916.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139800975.7916.7.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 10:22:55PM -0500, Trond Myklebust wrote:
> > - Benjamin LaHaise <bcrl@kvack.org> had an NFS problem ("NFS processes
> >   gettting stuck in D with currrent git").
> 
> ...but which was apparently not repeatable:
> 
>         As of this afternoon's tree
>         (6150c32589d1976ca8a5c987df951088c05a7542)  after the more
>         recent set of nfs patches, it seems to be behaving itself.  Will
>         keep sysrq enabled to see if it hits again, though.
> 
> I've had no news from Ben since then...

Confirmed: I've had no problems with NFS since that update, and my test 
box uses NFS regularly.

			-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
