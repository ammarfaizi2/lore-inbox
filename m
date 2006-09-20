Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWITRZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWITRZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWITRZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:25:26 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37851 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932088AbWITRZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:25:24 -0400
Date: Wed, 20 Sep 2006 12:24:50 -0500
From: Robin Holt <holt@sgi.com>
To: Jes Sorensen <jes@sgi.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bjorn_helgaas@hp.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       Dean Nelson <dcn@sgi.com>, Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch] mspec driver
Message-ID: <20060920172450.GA32042@lnx-holt.americas.sgi.com>
References: <yq0psdrc81u.fsf@jaguar.mkp.net> <20060920085939.47b753d9.rdunlap@xenotime.net> <45117047.60701@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45117047.60701@sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >These interfaces create a userspace interface, eh?
> >So those 3 functions could stand to have kernel-doc function
> >comments and have documentation in Documentation/ABI/ (see its
> >README file for more details).  Maybe check all of
> >Documentation/SubmitChecklist for other items...
> 
> Mmmmmmm, I'd need someone else to write that up, might take a little
> longer to get done. Robin know any volunteers?

Am I reading this right?  Jes, are you looking for a volunteer or a
"volunteer" :)

Sure, I can grab this and see about the documentation.  I assume you
want me to give you the blurb and your will add it to your patch?
If that assumption is wrong, please let me know.

Thanks,
Robin
