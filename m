Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132068AbRCVP5c>; Thu, 22 Mar 2001 10:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132069AbRCVP5N>; Thu, 22 Mar 2001 10:57:13 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:55363 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S132068AbRCVP5C>; Thu, 22 Mar 2001 10:57:02 -0500
Date: Thu, 22 Mar 2001 09:56:16 -0600
From: Nathan Straz <nstraz@sgi.com>
To: Wade Hampton <whampton@staffnet.com>
Cc: nbecker@fred.net, linux-kernel@vger.kernel.org
Subject: Re: regression testing
Message-ID: <20010322095616.A23245@sgi.com>
Mail-Followup-To: Wade Hampton <whampton@staffnet.com>, nbecker@fred.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <x88zoeeeyh8.fsf@adglinux1.hns.com> <3ABA1680.D1467727@staffnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3ABA1680.D1467727@staffnet.com>; from whampton@staffnet.com on Thu, Mar 22, 2001 at 10:13:04AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2001 at 10:13:04AM -0500, Wade Hampton wrote:
> nbecker@fred.net wrote:
> > Hi.  I was wondering if there has been any discussion of kernel
> > regression testing.  Wouldn't it be great if we didn't have to depend
> > on human testers to verify every change didn't break something?
> IMHO, much of the strength of Linux is the very large, extremely 
> diverse population of folks using it, testing it, beating on 
> the latest release, etc.  

The Linux community definately provides the configuration testing that
could never be done in a lab setting.  At least one that most companies
could afford.  

> However, a lab dedicated to testing the linux kernel, properly 
> funded, staffed, and containing the most common hardware and 
> software would be a good idea.  Does anyone have any idea how
> this could be accomplished?  Who could do it?  IBM?  What would
> it cost to setup a reasonable lab?  My guess would be dozens 
> of machines of various architectures, a staff of at least 10,
> several thousand square feet of space, and a good budget....
> Any takers?  

SGI is working on regression testing for Linux.  We have released some
of our tests and utilities under the Linux Test Project.  IMHO, a few
hundred tests aren't enough.  I need to make another big push with the
tests I've ported over the last few months.  

I believe there is some work in the Open Source Development Lab that
some IBMers could comment on.  I don't know if there is a web site
detailing their efforts yet.  

-- 
Nate Straz                                              nstraz@sgi.com
sgi, inc                                           http://www.sgi.com/
Linux Test Project                    http://oss.sgi.com/projects/ltp/
