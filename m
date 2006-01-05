Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWAEOiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWAEOiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWAEOiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:38:03 -0500
Received: from verein.lst.de ([213.95.11.210]:39834 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751368AbWAEOhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:37:41 -0500
Date: Thu, 5 Jan 2006 15:37:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Zach Brown <zach.brown@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Joel Becker <Joel.Becker@oracle.com>,
       Arjan van de Ven <arjan@infradead.org>, Christoph Hellwig <hch@lst.de>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: merging ocfs2?
Message-ID: <20060105143715.GA24927@lst.de>
References: <43BAF93A.10509@oracle.com> <Pine.LNX.4.64.0601041649270.3668@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601041649270.3668@g5.osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 04:50:49PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 3 Jan 2006, Zach Brown wrote:
> >
> > Joel has done the heavy lifting to bring its git repository up to date
> > so one should be able to pull from:
> > 
> >   http://oss.oracle.com/git/ocfs2.git
> 
> If Christoph is happy with it, and there has been no grumbling from -mm, I 
> can certainly merge it.

Last time I looked it seemed fine.  That's been about a month ago and
I don't have time to look over it again currently.  I'd say merge it and
blame everything on me if something horrible is hidden inside now :)

