Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWEMP4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWEMP4I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 11:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWEMP4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 11:56:07 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32005 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932458AbWEMP4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 11:56:06 -0400
Date: Sat, 13 May 2006 17:56:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Chris Wright <chrisw@sous-sol.org>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.16
Message-ID: <20060513155610.GB6931@stusta.de>
References: <20060511022547.GE25010@moss.sous-sol.org> <296295514.20060511123419@dns.toxicfilms.tv> <20060511173312.GI25010@moss.sous-sol.org> <200605131735.20062.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605131735.20062.ioe-lkml@rameria.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2006 at 05:35:19PM +0200, Ingo Oeser wrote:
> Hi Chris,
> 
> first of all: Thanks for the good work!
> 
> On Thursday, 11. May 2006 19:33, Chris Wright wrote:
> > Assigning any official severity is a bit of a slippery slope, but
> > making sure it's clear what type of issue (i.e. local DoS in this case)
> > is very reasonable.
> 
> Yes, I agree.
> 
> I would like to know:
> - local or remote exploitable
> - if a DoS: hang, only service failure, major slowdown 
> - privilege escalation possiible and how far (valid user, root, kernel-level)
> - required privileges (root or user)
> 
> That would help risk management a lot :-)
> 
> If you have a lot of time: Affected software components, but these can
> be taken from the patches/commit info or CVE.

The CVE should be enough for easily getting all information you 
requested.

Information whether it's a DoS or a root exploit is helpful, but any 
qualified person doing risk management will anyways lookup the CVE.

> Thanks & Regards
> 
> Ingo Oeser

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

