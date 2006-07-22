Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWGVBpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWGVBpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 21:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWGVBpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 21:45:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58022 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751024AbWGVBpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 21:45:38 -0400
Date: Fri, 21 Jul 2006 18:45:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Lang <dlang@digitalinsight.com>
Cc: kernel1@cyberdogtech.com, linux-kernel@vger.kernel.org
Subject: Re: How long to wait on patches?
Message-Id: <20060721184523.e99d295c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0607211541560.5705@qynat.qvtvafvgr.pbz>
References: <20060721205056.18b428eb.kernel1@cyberdogtech.com>
	<Pine.LNX.4.63.0607211541560.5705@qynat.qvtvafvgr.pbz>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2006 15:45:08 -0700 (PDT)
David Lang <dlang@digitalinsight.com> wrote:

> > I checked the FAQ but didn't see an answer to this.  Over the past few weeks 
> > I've submitted probably around 8 simple typo-fix patches all of which seemed 
> > to be approved by others on the list.  I've been following the GIT, but these 
> > patches haven't been merged yet.  I know people are busy with other things, 
> > probably more important, but I would like to know how long is "acceptable" to 
> > wait before I should re-submit a patch.  Obviously if enough time passes, 
> > patches start to break as source files change.  I don't mean to be a nuisance; 
> > I'm just trying to determine proper protocol.  That and the fact I can submit 
> > several more patches once I get some of these old ones out of my queue. :)
> 
> be sure to watch the -mm tree as well, a lot of patches are picked up by Andrew 
> to be fed to Linus that way

Yes, I hoover up unloved patches from the mailing list.  But only from this
mailing list, and there are probably lots of potentially-useful patches on
other lists which get lost.

However I have a personal i-dont-do-typo-patches policy.  Resending them to
kernel-janitor-discuss@lists.sourceforge.net would be a good idea.
