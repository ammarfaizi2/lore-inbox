Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUGLT4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUGLT4N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 15:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUGLT4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 15:56:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52612 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262079AbUGLT4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 15:56:09 -0400
From: Daniel Phillips <phillips@redhat.com>
Organization: Red Hat
To: sdake@mvista.com
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Date: Mon, 12 Jul 2004 15:54:12 -0400
User-Agent: KMail/1.6.2
Cc: Daniel Phillips <phillips@istop.com>, David Teigland <teigland@redhat.com>,
       linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>
References: <200407050209.29268.phillips@redhat.com> <200407120023.44773.phillips@redhat.com> <1089656497.608.4.camel@persist.az.mvista.com>
In-Reply-To: <1089656497.608.4.camel@persist.az.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407121554.12274.phillips@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 July 2004 14:21, Steven Dake wrote:
> On Sun, 2004-07-11 at 21:23, Daniel Phillips wrote:
> > On Monday 12 July 2004 00:08, Steven Dake wrote:
> > > On Sun, 2004-07-11 at 12:44, Daniel Phillips wrote:
> > > Oom conditions are another fact of life for poorly sized systems.
> > > If a cluster is within an OOM condition, it should be removed
> > > from the cluster (because it is in overload, under which unknown
> > > and generally bad behaviors occur).
> >
> > You missed the point.  The memory deadlock I pointed out occurs in
> > _normal operation_.  You have to find a way around it, or kernel
> > cluster services win, plain and simple.
>
> The bottom line is that we just don't know if any such deadlock
> occurs, under normal operations.

I thought I demonstrated that, should I restate?  You need to point out 
the flaw in my argument (about the deadlock, not about philosophy). 
If/when you succeed, I will be pleased.  Until you do succeed, there's 
a deadlock.

Regards,

Daniel
