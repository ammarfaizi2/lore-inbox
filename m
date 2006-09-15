Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWIOSMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWIOSMw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 14:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWIOSMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 14:12:52 -0400
Received: from chain.digitalkingdom.org ([64.81.49.134]:32958 "EHLO
	chain.digitalkingdom.org") by vger.kernel.org with ESMTP
	id S932130AbWIOSMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 14:12:51 -0400
Date: Fri, 15 Sep 2006 11:12:47 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bharath Ramesh <krosswindz@gmail.com>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Same MCE on 4 working machines (was Re: Early boot hang on recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM)
Message-ID: <20060915181247.GQ4610@chain.digitalkingdom.org>
References: <20060912223258.GM4612@chain.digitalkingdom.org> <20060914190548.GI4610@chain.digitalkingdom.org> <1158261249.7948.111.camel@mindpipe> <20060914191555.GJ4610@chain.digitalkingdom.org> <c775eb9b0609142242r45d184d2h8d7edd7dd5bc2a26@mail.gmail.com> <20060915174701.GN4610@chain.digitalkingdom.org> <1158344573.29932.111.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158344573.29932.111.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
From: Robin Lee Powell <rlpowell@digitalkingdom.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 07:22:53PM +0100, Alan Cox wrote:
> Ar Gwe, 2006-09-15 am 10:47 -0700, ysgrifennodd Robin Lee Powell:
> > I didn't know about mce=bootlog.  Neat.  It doesn't change anything,
> > though.  I've tried noacpi and many variants thereon; no change.
> > 
> > The most severe set of options I have record of trying is:
> > 
> > nosmp noapic mem=512M ide=nodma apm=off acpi=off desktop showopts
> 
> What did the various pci= options I suggested do - anything ?

I'm working on it.  :-)

It's a lot of options.  Be with you momentarily.

-Robin


-- 
http://www.digitalkingdom.org/~rlpowell/ *** http://www.lojban.org/
Reason #237 To Learn Lojban: "Homonyms: Their Grate!"
Proud Supporter of the Singularity Institute - http://singinst.org/
