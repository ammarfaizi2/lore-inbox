Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbVKQVHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbVKQVHP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVKQVHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:07:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46769 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964866AbVKQVHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:07:14 -0500
Date: Thu, 17 Nov 2005 13:06:43 -0800
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Dave Jones <davej@redhat.com>, Olivier Galibert <galibert@pobox.com>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051117210643.GG7991@shell0.pdx.osdl.net>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com> <20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost> <20051116220500.GF12505@elf.ucw.cz> <20051117170202.GB10402@dspnet.fr.eu.org> <1132257432.4438.8.camel@mindpipe> <20051117201204.GA32376@dspnet.fr.eu.org> <1132258855.4438.11.camel@mindpipe> <20051117203731.GG5772@redhat.com> <1132260851.5959.15.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132260851.5959.15.camel@mindpipe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> On Thu, 2005-11-17 at 15:37 -0500, Dave Jones wrote:
> > (Although every release we seem to trade one set of
> >  working sound drivers for a new set of broken ones). 
> 
> Because the ALSA project does not have access to the wide variety of
> hardware required to regression test every sound driver change.  People
> like Red Hat and OSDL do, but they don't help.  I always figured that
> this was because those entities consider audio support a low priority.

Haven't seen these heaps of audio hardware yet.  It's not an audio only
issue, it's pervasive across many device classes.  And hardware alone is
not quite sufficient.  Need ability to automate testing as well.
