Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbVIOLUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbVIOLUd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 07:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVIOLUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 07:20:33 -0400
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:2937 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750893AbVIOLUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 07:20:32 -0400
Date: Thu, 15 Sep 2005 07:20:25 -0400
From: Masoud Sharbiani <masouds@masoud.ir>
To: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Daniel Thaler <thalerd@in.tum.de>,
       David Lang <dlang@digitalinsight.com>, Hua Zhong <hzhong@gmail.com>,
       marekw1977@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: Automatic Configuration of a Kernel
Message-ID: <20050915112025.GA1229@masoud.ir>
References: <1126757808.13893.125.camel@mindpipe> <20050915081214.53141.qmail@web51005.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050915081214.53141.qmail@web51005.mail.yahoo.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 01:12:14AM -0700, Ahmad Reza Cheraghi wrote:
> 
> 
> --- Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Thu, 2005-09-15 at 05:37 +0200, Daniel Thaler
> > wrote:
> > > Lee Revell wrote:
> > > > Why does this have to be in the kernel again? 
> > Isn't this exactly what
> > > > you get with a fully modular config and hotplug?
> > > 
> > > It doesn't go in the kernel. If I understand
> > correctly, it's a script that is 
> > > invoked by 'make autoconfig'. Note that I didn't
> > read the patch, because it's a 
> > > .tgz on a website and I couldn't be bothered to
> > download it.
> > 
> > Oh, sorry.  Then read that as "what's the point"?
> > 
> > Lee
> > 
> It does go in the Kernel. The files are all kept in
> the directory <KERNEL>/scripts/kconfig/.
> And I changed a little bit the Makefile and the conf.c
> in the <KERNEl>/scrips/kconfig. 
> 
> 
OK, What he meant was: "Make it a as patch to, say, 2.6.14-rc1 and distribute it so that people can download and apply more easily, compared to a bigger tarbala"
cheers,
Masoud
