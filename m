Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbVIAO1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbVIAO1O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbVIAO1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:27:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55491 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965143AbVIAO1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:27:13 -0400
Date: Thu, 1 Sep 2005 15:27:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, David Teigland <teigland@redhat.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050901142708.GA24933@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
	David Teigland <teigland@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cluster@redhat.com
References: <20050901104620.GA22482@redhat.com> <20050901035939.435768f3.akpm@osdl.org> <1125586158.15768.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125586158.15768.42.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 03:49:18PM +0100, Alan Cox wrote:
> > - Why GFS is better than OCFS2, or has functionality which OCFS2 cannot
> >   possibly gain (or vice versa)
> > 
> > - Relative merits of the two offerings
> 
> You missed the important one - people actively use it and have been for
> some years. Same reason with have NTFS, HPFS, and all the others. On
> that alone it makes sense to include.

That's GFS.  The submission is about a GFS2 that's on-disk incompatible
to GFS.

