Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265517AbUH3X6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUH3X6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 19:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265722AbUH3X6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 19:58:37 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:56527 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265517AbUH3X6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 19:58:35 -0400
Subject: Re: submitting kernel patch for 3w-9xxx in 2.4
From: Lee Revell <rlrevell@joe-job.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Joel Jaeggli <joelja@darkwing.uoregon.edu>,
       James Colannino <lkml@colannino.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040830181821.GQ19844@mea-ext.zmailer.org>
References: <413217A3.4020906@colannino.org>
	 <20040829182333.GP19844@mea-ext.zmailer.org>
	 <Pine.LNX.4.61.0408291433210.32154@twin.uoregon.edu>
	 <20040830181821.GQ19844@mea-ext.zmailer.org>
Content-Type: text/plain
Message-Id: <1093910317.1348.22.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 30 Aug 2004 19:58:38 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 14:18, Matti Aarnio wrote:
> On Sun, Aug 29, 2004 at 02:35:47PM -0700, Joel Jaeggli wrote:
> > On Sun, 29 Aug 2004, Matti Aarnio wrote:
> > >
> > >May I suggest you don't use triple-x in its name.
> > >Such causes indigestion by several spam filters that people have
> > >deployed...  (The aic7xxx as prime example.)
> > 
> > got another identifier that would indicate a presence of a variable that 
> > won't have some other meaning to a filesystem or user? #### ???? *
> 
> No idea about that, but every time somebody reports problems with
> the AIC7XXX driver with either in all uppercase, or lowercase
> name in message subject, a dozen or so linux-kernel recipient systems
> do react adversely with something like "keep your spam".
> 
> For number wildcarding,  "N" is usable in some cases.
> e.g.  3w-9nnn  
> 
> I do urge you to consider rewriting configuration options, and file
> names so that triple-x doesn't appear in them.

Why?  That removes any incentive for the affected users to fix their
spam filters.  Any halfway intelligent filter would pass LKML mail with
'aic7xxx' in the subject.

Lee

