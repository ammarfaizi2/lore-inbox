Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030512AbVIIUsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030512AbVIIUsj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbVIIUsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:48:38 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:8050 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030512AbVIIUsi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:48:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I3lKxn4DBamA4HzLRUXV813ZSCJwzLbgGdKc6Xc8Tc6GtYq/4sfzdOPPZK/RaaVjBkTHitpwserKRhFKWtj+GB8GQcg7f1SmpwXxZwZ/tgGDQnBg5Kd5g18+SNrw76ktAJBtdzayOiKi9msKOZoM6Owiticsw5cyddKT2VXQo9g=
Message-ID: <29495f1d050909134834da4a57@mail.gmail.com>
Date: Fri, 9 Sep 2005 13:48:35 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: Hans Reiser <reiser@namesys.com>
Subject: Re: List of things requested by lkml for reiser4 inclusion (to review)
Cc: Chris Shoemaker <c.shoemaker@cox.net>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <4321F3AB.4070701@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509091817.39726.zam@namesys.com> <4321C806.60404@namesys.com>
	 <20050909175739.GA32503@pe.Belkin> <4321F3AB.4070701@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/05, Hans Reiser <reiser@namesys.com> wrote:
> Chris Shoemaker wrote:
> 
> >On Fri, Sep 09, 2005 at 10:36:06AM -0700, Hans Reiser wrote:
> >
> >
> >>If we lose every remaining point of this list, we can generate a patch
> >>in a few days, because the VFS work was the only substantive (in coding
> >>hours) task, and it is done.  Do I remember right that the submission
> >>deadline is a week from Monday for 2.6.14 inclusion?
> >>
> >>
> >
> >No.  14 days from release date of 2.6.13, which was 8/29, so deadline
> >is 9/12, this coming Monday.
> >
> >-chris
> >
> >
> >
> >
> IIRC, Linus announced that since he was going on vacation for 7 days,
> this release only it would be 3 weeks, so it is a week from Monday that
> we must submit by, yes?

According to his mail (http://lkml.org/lkml/2005/9/8/208):

"As per the new merge policies that were discussed during LKS in Ottawa 
earlier during the summer, I'm going to accept new stuff for 2.6.14 only 
during the first two weeks after 2.6.13 was released.

That release was ten days ago, so you've got four more days before I don't 
want any big merges."

Thanks,
Nish
