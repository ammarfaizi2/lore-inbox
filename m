Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWBPB3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWBPB3y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 20:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWBPB3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 20:29:54 -0500
Received: from [218.25.172.144] ([218.25.172.144]:6667 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1751214AbWBPB3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 20:29:53 -0500
Date: Thu, 16 Feb 2006 09:29:54 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Avi Kivity <avi@argo.co.il>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] make sysctl_overcommit_memory enumeration sensible
Message-ID: <20060216012954.GB2702@localhost.localdomain>
References: <20060215085456.GA2481@localhost.localdomain> <20060215010559.55b55414.akpm@osdl.org> <20060215093136.GA2600@localhost.localdomain> <43F30346.1070802@argo.co.il> <20060215104345.GA2879@localhost.localdomain> <43F326DF.8050700@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F326DF.8050700@argo.co.il>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 03:04:31PM +0200, Avi Kivity wrote:
> Coywolf Qi Hunt wrote:
> 
> >>in my /etc/sysctl.conf, its meaning silently changes. I'll know about 
> >>it during the next oomkiller pass.
> >>   
> >>
> >
> >Indeed. See, the breakage doesn't hurt.

Indeed. See, the breakage doesn't hurt (much).

> > 
> >
> I guess we have different definitions for 'hurt' in our dictionaries.
> 
> -- 
> error compiling committee.c: too many arguments to function
> 
> 

-- 
Coywolf Qi Hunt
