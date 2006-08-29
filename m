Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965296AbWH2XEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965296AbWH2XEa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 19:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965264AbWH2XEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 19:04:30 -0400
Received: from zakopane.cs.ubc.ca ([198.162.51.68]:43141 "EHLO
	mail.quuxuum.com") by vger.kernel.org with ESMTP id S965296AbWH2XE3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 19:04:29 -0400
Date: Tue, 29 Aug 2006 16:04:06 -0700
From: Brendan Cully <brendan@kublai.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Roland Dreier <rdreier@cisco.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1 of 23] IB/ipath - More changes to support InfiniPath on PowerPC 970 systems
Message-ID: <20060829230406.GA3223@xanadu.kublai.com>
References: <44809b730ac95b39b672.1156530266@eng-12.pathscale.com> <adabqq8tx9z.fsf@cisco.com> <1156537194.31531.38.camel@sardonyx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156537194.31531.38.camel@sardonyx>
X-Operating-System: Darwin 8.7.0 Power Macintosh
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 25 August 2006 at 13:19, Bryan O'Sullivan wrote:
> On Fri, 2006-08-25 at 12:45 -0700, Roland Dreier wrote:
> > How did you generate these patches?
> 
> Using Mercurial.  
> 
> > because the line
> > 
> > diff --git a/drivers/infiniband/hw/ipath/Makefile b/drivers/infiniband/hw/ipath/Makefile
> > 
> > makes git think it's a git diff, but git doesn't put dates on the
> > filename lines.
> 
> Ah, interesting.  Looks like a bug in the git-compatible patch
> generator, then.  Sorry about that.

I've just posted a fix to the mercurial list.
