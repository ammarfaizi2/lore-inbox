Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVBNXQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVBNXQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 18:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVBNXQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 18:16:27 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:46367 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261172AbVBNXQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 18:16:23 -0500
Date: Mon, 14 Feb 2005 15:16:05 -0800
From: Greg KH <gregkh@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Prakash Punnoor <prakashp@arcor.de>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Patrick McFarland <pmcfarland@downeast.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Message-ID: <20050214231605.GA13969@suse.de>
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net> <20050211011609.GA27176@suse.de> <1108354011.25912.43.camel@krustophenia.net> <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de> <1108422240.28902.11.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108422240.28902.11.camel@krustophenia.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 06:04:00PM -0500, Lee Revell wrote:
> On Mon, 2005-02-14 at 09:51 +0100, Prakash Punnoor wrote:
> > Paolo Ciarrocchi schrieb:
> > > On Sun, 13 Feb 2005 23:06:51 -0500, Lee Revell <rlrevell@joe-job.com> wrote:
> > >
> > >>On Thu, 2005-02-10 at 17:16 -0800, Greg KH wrote:
> > >>
> > >>>All distros are trying to reduce boot time.
> > >>
> > >>They certainly aren't all trying very hard.  Debian and Fedora (last
> > >>time I checked) do not even run the init scripts in parallel.
> > >
> > >
> > > Is there any distro that is running the init scripts in parallel ?
> > 
> > Gentoo.
> > 
> 
> Last I heard Gentoo does not even do it by default.

Gentoo doesn't do much "by default" :)  But it is an option.

> I don't see why so much effort goes into improving boot time on the
> kernel side when the most obvious user space problem is ignored.

What user space problem is that?

thanks,

greg k-h
