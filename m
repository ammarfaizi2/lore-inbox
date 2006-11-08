Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754505AbWKHJ7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbWKHJ7c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 04:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754498AbWKHJ7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 04:59:32 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:11201 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1754505AbWKHJ7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 04:59:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZgGZe6k4Bmq6p/jLHf7h6JwdpahQSWvW5i4e+5rqzniNgkDiNgzKFi7swVLjbXNPU3rWkztCYdMkaXtB3y301py/M/zC/ARv4rBCH9OcWw3Ss3PVdOuyZ6lWuBnHOTp72icVPeWaxgwqzfggUcG9sc9SIyIXe5UsNdYBQJn7KnA=
Message-ID: <5a4c581d0611080159x381a9afdy26f3dd1f1ed704f1@mail.gmail.com>
Date: Wed, 8 Nov 2006 10:59:30 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Nigel Cunningham" <ncunningham@linuxmail.org>
Subject: Re: Linux 2.6.19-rc5
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <1162979018.12585.0.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	 <1162979018.12585.0.camel@nigel.suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/06, Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> Gidday.
>
> On Tue, 2006-11-07 at 18:33 -0800, Linus Torvalds wrote:
> > Ok, things are finally calming down, it seems.
> >
> > The -rc5 thing is mainly a few random architecture updates (arm, mips,
> > uml, avr, power) and the only really noticeable one there is likely some
> > fixes to the local APIC accesses on x86, which apparently fixes a few
> > machines.
> >
> > The rest is really mostly one-liners (or close) to various subsystems. New
> > PCI ID's, trivial fixes, cifs, dvb, things like that. I'm feeling better
> > about this - there may be a -rc6, but maybe we don't even need one.
> >
> > As usual, thanks to everybody who tested and chased down some of the
> > regressions,
> >
> >               Linus
>
> The patch etc doesn't seem to be available yet. (The front page is still
> showing -rc4, for example).

The patch is available, it's just the kernel.org home that
 isn't updated.

http://www.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.19-rc5.bz2

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)
