Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVCROT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVCROT3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 09:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVCROT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 09:19:29 -0500
Received: from sd291.sivit.org ([194.146.225.122]:21256 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261615AbVCROT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 09:19:27 -0500
Date: Fri, 18 Mar 2005 15:21:25 +0100
From: Stelian Pop <stelian@popies.net>
To: lm@bitmover.com, andersen@codepoet.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BKCVS broken ?
Message-ID: <20050318142124.GA3333@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>, lm@bitmover.com,
	andersen@codepoet.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050317144522.GK22936@hottah.alcove-fr> <20050318001053.GA23358@bitmover.com> <20050318055040.GA16780@codepoet.org> <20050318063853.GA30603@bitmover.com> <20050318090047.GA12314@sd291.sivit.org> <20050318141345.GA2227@bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318141345.GA2227@bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 06:13:45AM -0800, Larry McVoy wrote:

> On Fri, Mar 18, 2005 at 10:00:49AM +0100, Stelian Pop wrote:
> > On Thu, Mar 17, 2005 at 10:38:53PM -0800, Larry McVoy wrote:
> > 
> > > Hey, it's open source, I'm hoping that people will take that code and
> > > evolve it do whatever they need.  We're willing to do what we can on
> > > this end if people need protocol changes to support new features, 
> > > time permitting.  Think of that code as a prototype.  It's really
> > > simple, you can hack it trivially.
> > 
> > 	------------
> > 	if (strncmp("bk://", p, 5)) return (1);
> > 	------------
> > 
> > Any chance this could be made to work over http ?
> 
> I don't see why not.  It will take some hacking though.  Can you live 
> without it for a bit or is it urgent?

It's not urgent at all...

Thanks.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
