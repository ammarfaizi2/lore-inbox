Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269252AbUISNLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269252AbUISNLk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 09:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269243AbUISNK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 09:10:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15787 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269241AbUISNKs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 09:10:48 -0400
Date: Sun, 19 Sep 2004 14:10:47 +0100
From: Matthew Wilcox <willy@debian.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       HPPA List <parisc-linux@parisc-linux.org>
Subject: Re: [parisc-linux] The new iomap interface
Message-ID: <20040919131047.GI642@parcelfarce.linux.theplanet.co.uk>
References: <20040917124612.GS642@parcelfarce.linux.theplanet.co.uk> <20040917162430.GA7984@colo.lackof.org> <20040917165031.GT642@parcelfarce.linux.theplanet.co.uk> <1095436838.26146.22.camel@localhost.localdomain> <20040919092226.GA5158@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040919092226.GA5158@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2004 at 11:22:26AM +0200, Christoph Hellwig wrote:
> On Fri, Sep 17, 2004 at 05:00:39PM +0100, Alan Cox wrote:
> > On Gwe, 2004-09-17 at 17:50, Matthew Wilcox wrote:
> > > On Fri, Sep 17, 2004 at 10:24:30AM -0600, Grant Grundler wrote:
> > > > Interesting. I'm not sure this new scheme provides any special hooks
> > > > that we can't already do today.
> > > > Did Linus write why he wants iomap? Have a URL handy?
> > 
> > Discussion on linux-arch originally I think
> 
> Does anyone have a pointer to the list archives for that linux-arch
> thing?

I believe there are none.  BTW, the iomap discussion didn't happen
on linux-arch.  Linus posted saying "hey, I've added __iomem markers
for sparse's benefit; isn't this cool?" and there was some discussion
around that, but nothing about the iomap() interface.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
