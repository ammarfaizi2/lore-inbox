Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261490AbTC3Qnx>; Sun, 30 Mar 2003 11:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261491AbTC3Qnx>; Sun, 30 Mar 2003 11:43:53 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:61196 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261490AbTC3Qnw>; Sun, 30 Mar 2003 11:43:52 -0500
Date: Sun, 30 Mar 2003 17:55:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nicholas Wourms <nwourms@myrealbox.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: Update direct-rendering to current DRI CVS tree.
Message-ID: <20030330175502.A15123@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nicholas Wourms <nwourms@myrealbox.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
References: <200303300712.h2U7CVB32581@hera.kernel.org> <20030330114544.GB16060@suse.de> <3E86FBE2.8080804@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E86FBE2.8080804@myrealbox.com>; from nwourms@myrealbox.com on Sun, Mar 30, 2003 at 09:14:58AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 30, 2003 at 09:14:58AM -0500, Nicholas Wourms wrote:
> Dave Jones wrote:
> >  >  #if LINUX_VERSION_CODE <= KERNEL_VERSION(2,4,2)
> >  >  #define down_write down
> >  >  #define up_write up
> > 
> > #if can go, like it did in other parts of the patch.
> 
> What will replace it?

Nothing.  2.4.0/2.4.1/2.4.2 are too buggy to be used.

