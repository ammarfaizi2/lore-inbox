Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262994AbVCDS7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbVCDS7b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 13:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbVCDSzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 13:55:47 -0500
Received: from S010600c0f014b14a.ss.shawcable.net ([70.64.60.7]:6410 "HELO
	discworld.dyndns.org") by vger.kernel.org with SMTP id S262972AbVCDSue
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 13:50:34 -0500
Date: Fri, 4 Mar 2005 12:50:05 -0600
From: Charles Cazabon <linux@discworld.dyndns.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050304185005.GA7576@discworld.dyndns.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org> <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com> <20050303151752.00527ae7.akpm@osdl.org> <1109894511.21781.73.camel@localhost.localdomain> <20050303182820.46bd07a5.akpm@osdl.org> <1109933804.26799.11.camel@localhost.localdomain> <20050304032820.7e3cb06c.akpm@osdl.org> <1109940685.26799.18.camel@localhost.localdomain> <Pine.LNX.4.58.0503040959030.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503040959030.25732@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> 
> What I'd like to set up is the reverse. The same way the "wild" kernels
> tend to layer on top of my standard kernel, I'd like to have a lower
> level, the "anti-wild" kernel.  Something that is comprised of patches
> that _everybody_ can agree on, and that doesn't get anything else. AT ALL.
> 
> And that means that such a kernel would not get all patches that you'd 
> want. That's fine.

Let's see if I understand your intent: this new tree would be a better base
for things like -ac than the mainline Linus kernel.  It would always be a
single short branch off the latest mainline stable kernel.  It would probably
form a good base for vendor kernels and other stability-needed kernels, but by
itself wouldn't necessarily be at that level of predictability.

Does that accurately sum up what you're trying to get across?

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:               http://pyropus.ca/software/
-----------------------------------------------------------------------
