Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268991AbUIXSCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268991AbUIXSCH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 14:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268971AbUIXSCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 14:02:07 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:14098 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268995AbUIXR67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 13:58:59 -0400
Date: Fri, 24 Sep 2004 18:58:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Wysochanski <davidw@netapp.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: reiserfs and SCSI oops seen in 2.6.9-rc2 with local SCSI disk IO
Message-ID: <20040924185852.A30140@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Wysochanski <davidw@netapp.com>,
	Matthew Wilcox <matthew@wil.cx>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <4154372C.7070506@netapp.com> <20040924151828.GC16153@parcelfarce.linux.theplanet.co.uk> <4154404B.3070705@netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4154404B.3070705@netapp.com>; from davidw@netapp.com on Fri, Sep 24, 2004 at 11:42:03AM -0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 11:42:03AM -0400, David Wysochanski wrote:
> I've been seeing a lot of problems with reiserfs that I
> don't see on ext2 or ext3, so I would tend to agree with you.
> Do you know where I could post for the reiserfs folks?

linux-fsdevel@vger.kernel.org is the list for filesystem development, but
for error reports lkml is probably also okay.

