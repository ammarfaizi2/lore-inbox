Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbWBVI4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbWBVI4V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 03:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWBVI4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 03:56:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20896 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932345AbWBVI4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 03:56:20 -0500
Subject: Re: FMODE_EXEC or alike?
From: Steven Whitehouse <swhiteho@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Oleg Drokin <green@linuxhacker.ru>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20060222010347.GA27318@taniwha.stupidest.org>
References: <20060220221948.GC5733@linuxhacker.ru>
	 <20060221103949.GD19349@infradead.org>
	 <20060222010347.GA27318@taniwha.stupidest.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Wed, 22 Feb 2006 08:59:00 +0000
Message-Id: <1140598740.6400.610.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Also GFS2 (which we hope to be ready to submit to the kernel shortly)
would want to make use of this feature. Its been a long standing entry
on our TODO list,

Steve.

On Tue, 2006-02-21 at 17:03 -0800, Chris Wedgwood wrote:
> On Tue, Feb 21, 2006 at 10:39:49AM +0000, Christoph Hellwig wrote:
> 
> > The patch looks fine to me.  We can put it in once we'll put in the
> > full lustre client.
> 
> ocfs2 could probably use it sooner or later surely?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

