Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263404AbTIWVIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 17:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbTIWVIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 17:08:06 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:41358
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263404AbTIWVIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 17:08:04 -0400
Date: Tue, 23 Sep 2003 23:08:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Matthew Wilcox <willy@debian.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030923210808.GN1269@velociraptor.random>
References: <20030922194833.GA2732@velociraptor.random> <20030923015121.GA13172@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923015121.GA13172@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 02:51:21AM +0100, Matthew Wilcox wrote:
> On Mon, Sep 22, 2003 at 09:48:33PM +0200, Andrea Arcangeli wrote:
> > Date: 2003/08/26 19:28:13
> > Author: willy
> 
> Must be a different willy.
> 
> > I added the config line to all archs. I used copy paste, so either I broke them
> > all, either none. I'll start a compilation on my alpha while I'm on the way
> > home, to check. I you have questions, please do ask.
> 
> ... because I don't have an Alpha ;-)

;)

if Marcelo would be using open source code to exports the patchsets in
his tree, we could fix it to add the email address along the name in the
checkin logs metadata, to avoid this sort of mistakes.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
