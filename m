Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVCROOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVCROOz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 09:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVCROOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 09:14:55 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:45789 "EHLO
	mail.bitmover.com") by vger.kernel.org with ESMTP id S261612AbVCROOv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 09:14:51 -0500
Date: Fri, 18 Mar 2005 06:13:45 -0800
To: Stelian Pop <stelian@popies.net>, andersen@codepoet.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BKCVS broken ?
Message-ID: <20050318141345.GA2227@bitmover.com>
Mail-Followup-To: lm@bitmover.com, Stelian Pop <stelian@popies.net>,
	andersen@codepoet.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050317144522.GK22936@hottah.alcove-fr> <20050318001053.GA23358@bitmover.com> <20050318055040.GA16780@codepoet.org> <20050318063853.GA30603@bitmover.com> <20050318090047.GA12314@sd291.sivit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318090047.GA12314@sd291.sivit.org>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 10:00:49AM +0100, Stelian Pop wrote:
> On Thu, Mar 17, 2005 at 10:38:53PM -0800, Larry McVoy wrote:
> 
> > Hey, it's open source, I'm hoping that people will take that code and
> > evolve it do whatever they need.  We're willing to do what we can on
> > this end if people need protocol changes to support new features, 
> > time permitting.  Think of that code as a prototype.  It's really
> > simple, you can hack it trivially.
> 
> 	------------
> 	if (strncmp("bk://", p, 5)) return (1);
> 	------------
> 
> Any chance this could be made to work over http ?

I don't see why not.  It will take some hacking though.  Can you live 
without it for a bit or is it urgent?
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
