Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbUJZUrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbUJZUrZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbUJZUq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:46:29 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:22977 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261456AbUJZUoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 16:44:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=XfSl4FzgRMXYEAW9TBhhx88Kqvp+1g2d445Zok6osk0//56NzTA8r3wWhnHVjsN5EoV9VUbh5qImuTDiV1qWHVynYvrLaPIMnB/GhmpKO7tv16JBOdauAmhcvz+btFwzKGMBpTnLCOtLwgkcWfSfIZqJYF+rcsGWBOD1GNPAfVI=
Message-ID: <4d8e3fd304102613447c0156b2@mail.gmail.com>
Date: Tue, 26 Oct 2004 22:44:21 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Dave Jones <davej@redhat.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, alan@lxorguk.ukuu.org.uk,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Let's make a small change to the process
In-Reply-To: <20041026203644.GD2307@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200410260644.47307.edt@aei.ca>
	 <00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin>
	 <4d8e3fd3041026050823d012dc@mail.gmail.com>
	 <877jpdcnf5.fsf@barad-dur.crans.org>
	 <4d8e3fd304102613165b2fb283@mail.gmail.com>
	 <20041026203644.GD2307@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004 16:36:44 -0400, Dave Jones <davej@redhat.com> wrote:
> On Tue, Oct 26, 2004 at 10:16:08PM +0200, Paolo Ciarrocchi wrote:
> 
> > The .Y patchset contains only important security fix (all stuff you
> > think are important) and is weekly uploaded to kernel.org
> >
> > Doing that, people:
> > -  can stop running "personal version of vanilla kernel
> > -  don't need to wait till next Linus' release in order to have a
> > security bug fixed
> >
> > We, of course, need a maintainer for it,
> > maybe someone from OSDL (Randy?), maybe wli (he maintained his tree
> > for a long time), maybe Alan (that is already applying these kind of
> > fixes to his tree), maybe someone else... ?
> 
> 2.6-ac seems to be filling this role right now.
> 

Correct.
But as I user I tend to look at kernel.org and download "The latest
stable version of the Linux kernel is".

If the goal of -ac is to only include those fixes, why can't we rename
it in something more "intuitive" for the final users ?
Do you see what I mean ?


-- 
Paolo
