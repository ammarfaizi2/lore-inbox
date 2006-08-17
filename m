Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWHQHbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWHQHbq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 03:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWHQHbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 03:31:46 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:1682 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932190AbWHQHbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 03:31:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=O5b04+NNh4H1McLCyFH8LHN4Gsma6ONGWu3HHCBeiWegTG/ZJWOssumnRFmRMIaXRM61AMLwpu/UvsaDroDNkv7iGkMWs415YdnN+nP0RPDkDbEjI1hdOmWYYcLYw8zW2ZeudgODKHs/Wj5KxNhFy0rKPP0CiQlnWy1KkSb0nRU=
From: Patrick McFarland <diablod3@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: GPL Violation?
Date: Thu, 17 Aug 2006 03:32:51 -0400
User-Agent: KMail/1.9.1
Cc: Anonymous User <anonymouslinuxuser@gmail.com>,
       linux-kernel@vger.kernel.org
References: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com> <200608170242.40969.diablod3@gmail.com> <1155797656.4494.24.camel@laptopd505.fenrus.org>
In-Reply-To: <1155797656.4494.24.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608170332.53556.diablod3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 August 2006 02:54, Arjan van de Ven wrote:
> On Thu, 2006-08-17 at 02:42 -0400, Patrick McFarland wrote:
> > On Thursday 17 August 2006 01:48, Anonymous User wrote:
> > > I work for a company that will be developing an embedded Linux based
> > > consumer electronic device.
> > >
> > > I believe that new kernel modules will be written to support I/O
> > > peripherals and perhaps other things.  I don't know the details right
> > > now.  What I am trying to do is get an idea of what requirements there
> > > are to make the source code available under the GPL.
> >
> > I am not a lawyer, and I suggest your company speak with one before doing
> > this. (And most likely, someone from the list will correct me if I get
> > something wrong).
> >
> > However, your company only has to release any code they use, preferably
> > in the form of unmodified tarballs (pointing to project websites for
> > downloads isn't valid anymore) plus patches against said unmodified
> > tarballs if modified. If not modified, you still have to release the
> > unmodified tarballs.
> >
> > They don't have to release source code for any module you wrote from
> > scratch themselves, but said modules cannot say they are GPL (ie, they
> > have to poison the kernel).
>
> Just as a warning: This is your own legal opinion/advice, one which is
> apparently not shared with many other kernel developers, including me.
> For example see Greg's OLS keynote:
> http://www.kroah.com/log/2006/07/23/#ols_2006_keynote
> or some of Linus' emails on this topic:
> http://cvs.fedora.redhat.com/viewcvs/*checkout*/rpms/kernel/devel/COPYING.m
>odules?rev=1.5
>
> I hope you have talked to a lawyer about your advice, but I sort of
> doubt it since your answer doesn't sound like something a lawyer will
> tell you (it sure doesn't match what the various lawyers I talked to
> told me, not at all)

Like I told him, he needs to talk to a lawyer. Also, Linus probably won't 
agree with me because I said closed source modules are possible. If Linus 
wants those to not be possible, then hes going to have to change the 
licensing agreement altogether; which, honestly, I wish he would. 

Closed source modules are lame, and against the spirit of open source, but 
that still doesn't make them against the license.

-- 
Patrick McFarland || www.AdTerrasPerAspera.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids,
we'd all be running around in darkened rooms, munching magic pills and
listening to repetitive electronic music." -- Kristian Wilson, Nintendo,
Inc, 1989

