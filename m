Return-Path: <linux-kernel-owner+w=401wt.eu-S964819AbWLLXOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWLLXOt (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 18:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWLLXOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 18:14:49 -0500
Received: from MAIL.13thfloor.at ([213.145.232.33]:48488 "EHLO
	MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964819AbWLLXOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 18:14:48 -0500
Date: Wed, 13 Dec 2006 00:13:15 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew de Quincey <adq_dvb@lidskialf.net>,
       Cedric Le Goater <clg@fr.ibm.com>, containers@lists.osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       v4l-dvb-maintainer@linuxtv.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH/RFC] kthread API conversion for dvb_frontend and av7110
Message-ID: <20061212231315.GA32222@MAIL.13thfloor.at>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew de Quincey <adq_dvb@lidskialf.net>,
	Cedric Le Goater <clg@fr.ibm.com>, containers@lists.osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	v4l-dvb-maintainer@linuxtv.org, Andrew Morton <akpm@osdl.org>
References: <45019CC3.2030709@fr.ibm.com> <4509C4A5.5030600@fr.ibm.com> <20060914221024.GB26916@MAIL.13thfloor.at> <200611170150.02207.adq_dvb@lidskialf.net> <m1ejr4rabb.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ejr4rabb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 03:58:16PM -0700, Eric W. Biederman wrote:
> Andrew de Quincey <adq_dvb@lidskialf.net> writes:
> 
> > [snip]
> >
> >> correct, will fix that up in the next round
> >>
> >> thanks for the feedback,
> >> Herbert
> >
> > Hi - the conversion looks good to me.. I can't really offer any more 
> > constructive suggestions beyond what Cedric has already said. 
> >
> > Theres another thread in dvb_ca_en50221.c that could be converted as well 
> > though, hint hint ;)
> >
> > Apologies for the delay in this reply - I've been hibernating for a bit.
> 
> Guys where are we at on this conversion?

I can take a look at it in the next few days, but
I have no hardware to test that, so it would be
good to get in contact with somebody who does

best,
Herbert

> Eric
