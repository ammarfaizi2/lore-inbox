Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965353AbVKHDap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965353AbVKHDap (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965366AbVKHDap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:30:45 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:60068 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965353AbVKHDao
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:30:44 -0500
Date: Tue, 8 Nov 2005 03:30:40 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Neil Brown <neilb@suse.de>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Subject: Re: [OT] Re: [PATCH 3/18] allow callers of seq_open do allocation themselves
Message-ID: <20051108033040.GQ7992@ftp.linux.org.uk>
References: <E1EZInj-0001Eh-9T@ZenIV.linux.org.uk> <20051107190340.129bc8c3.rdunlap@xenotime.net> <17264.6769.472245.973213@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17264.6769.472245.973213@cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 02:24:33PM +1100, Neil Brown wrote:
> On Monday November 7, rdunlap@xenotime.net wrote:
> > On Tue, 08 Nov 2005 02:01:31 +0000 Al Viro wrote:
> > 
> > > From: Al Viro <viro@zeniv.linux.org.uk>
> > > Date: 1131401734 -0500
> > 
> > What format is that date in, please?
> > 
> 
>  %s %z
> 
> (as date(1) understands it).
> 
> Or was this a rhetorical question, meaning to say "Who in their right
> mind would used that sort of date format on a public mailing list?" :-)

git format-patch and used by git applymbox and friends...
