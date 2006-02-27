Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWB0IDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWB0IDt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWB0IDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:03:49 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:930 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932180AbWB0IDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:03:48 -0500
Date: Mon, 27 Feb 2006 09:02:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Red Hat ES4 GPL Issues?
Message-ID: <20060227080229.GA32092@elte.hu>
References: <43FCFDC6.9090109@soleranetworks.com> <20060223145920.GA1311407@hiwaay.net> <7c3341450602230831m1265e49g@mail.gmail.com> <1140713030.4672.75.camel@laptopd505.fenrus.org> <43FDFBDE.2040304@wolfmountaingroup.com> <1140716828.4672.80.camel@laptopd505.fenrus.org> <43FE02DA.90003@wolfmountaingroup.com> <20060223193812.GF29940@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060223193812.GF29940@csclub.uwaterloo.ca>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:

> On Thu, Feb 23, 2006 at 11:45:46AM -0700, Jeff V. Merkey wrote:
> > I know but this deviates from how they did it in the past.  No worry, 
> > sooner or later Linux will get so
> > large in these distros, you will need a DVD to hold all of it, so I can 
> > understand if space was at a premium
> > on those CD iso images.
> 
> Debian takes 2 DVDs for binaries and 2 DVDs for sources.  I think we 
> may need BD-ROM or HD-DVD real soon. :)

btw., this 5GB+ of compressed source code means (using conservative 
calculations, and taking code duplication across projects and packages 
into account), that the raw linecount of the OSS source codebase 
distributed via Debian has exceeded half a billion (500 million) lines 
of code. Wow!

That makes Linux and OSS the largest man-made science project in
history. It also means that the cost of redeveloping the Debian codebase
using commerical methods could exceed 100 billion US dollars. [Sidenote:
no wonder the only remaining anti-Linux company (MS) is worried - they
are quite big and rich, but no way can they hold up against such type of
grass-roots exponential growth, and they know it.]

	Ingo
