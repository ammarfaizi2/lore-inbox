Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266798AbUIAOyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbUIAOyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 10:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266810AbUIAOyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 10:54:40 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:29191 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266798AbUIAOyj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 10:54:39 -0400
Date: Wed, 1 Sep 2004 16:56:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ian Wienand <ianw@gelato.unsw.edu.au>, Christoph Hellwig <hch@lst.de>
Subject: Re: kbuild: Support LOCALVERSION
Message-ID: <20040901145646.GA7252@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Ian Wienand <ianw@gelato.unsw.edu.au>,
	Christoph Hellwig <hch@lst.de>
References: <20040831192642.GA15855@mars.ravnborg.org> <20040901134341.GT6985@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901134341.GT6985@lug-owl.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 03:43:41PM +0200, Jan-Benedict Glaw wrote:
> Maybe it would also be good (in the longer term)
> to introduce a config name into one of the Kconfig files, which is
> preserved in the .config file (eg. SuSE does something like that and
> even while I'm not a SuSE user, it's really dandy at some times, esp.
> for things like "SMP-4GB", "VAX-KA4x" and the like). It's basically like
> adding the defconfig_* name to some of the variables :-)

Ian addedconfig CONFIG_LOCALVERSION to a Kconfig file. I will
try to add it and see how it turns out. If Ian does not beat me..

> PS: When will the package support show up?
UML needs to be finised first.
I have several packages related patches queued up. But I want
to give it an extra look since there are several basic issues
I am not satisfied with.

	Sam
