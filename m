Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269672AbTGVGVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 02:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269685AbTGVGVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 02:21:10 -0400
Received: from us01smtp1.synopsys.com ([198.182.44.79]:8625 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S269672AbTGVGVI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 02:21:08 -0400
Date: Tue, 22 Jul 2003 08:36:03 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1+bk: NFS client-side freezes
Message-ID: <20030722063603.GH13611@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
References: <20030719202253.GA1716@steel.home> <shsu19gn70h.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shsu19gn70h.fsf@charged.uio.no>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[nfs@sf.net removed from cc, useless without subscription]

Trond Myklebust, Mon, Jul 21, 2003 00:54:54 +0200:
> 
> Please duplicate with the standard kernel.
> 

Well, seem the assorted collection of -mm and -ac patches I did was the
problem. Please do not ask me, what patches these were :-/

I could not reproduce the freeze with plain 2.6.0-test1 whatever I
tried. Also interactive behaviour feels better, so I stick to it for a
while.

-alex
