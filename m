Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVBNXEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVBNXEJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 18:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVBNXEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 18:04:09 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47765 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261220AbVBNXEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 18:04:01 -0500
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
From: Lee Revell <rlrevell@joe-job.com>
To: Prakash Punnoor <prakashp@arcor.de>
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, Greg KH <gregkh@suse.de>,
       Patrick McFarland <pmcfarland@downeast.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <42106685.40307@arcor.de>
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>
	 <20050211011609.GA27176@suse.de>
	 <1108354011.25912.43.camel@krustophenia.net>
	 <4d8e3fd305021400323fa01fff@mail.gmail.com>  <42106685.40307@arcor.de>
Content-Type: text/plain
Date: Mon, 14 Feb 2005 18:04:00 -0500
Message-Id: <1108422240.28902.11.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-14 at 09:51 +0100, Prakash Punnoor wrote:
> Paolo Ciarrocchi schrieb:
> > On Sun, 13 Feb 2005 23:06:51 -0500, Lee Revell <rlrevell@joe-job.com> wrote:
> >
> >>On Thu, 2005-02-10 at 17:16 -0800, Greg KH wrote:
> >>
> >>>All distros are trying to reduce boot time.
> >>
> >>They certainly aren't all trying very hard.  Debian and Fedora (last
> >>time I checked) do not even run the init scripts in parallel.
> >
> >
> > Is there any distro that is running the init scripts in parallel ?
> 
> Gentoo.
> 

Last I heard Gentoo does not even do it by default.

I don't see why so much effort goes into improving boot time on the
kernel side when the most obvious user space problem is ignored.

Lee

