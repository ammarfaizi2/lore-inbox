Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268016AbTB1QyV>; Fri, 28 Feb 2003 11:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268031AbTB1QyV>; Fri, 28 Feb 2003 11:54:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59711 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S268016AbTB1QyU>; Fri, 28 Feb 2003 11:54:20 -0500
To: Bill Davidsen <davidsen@tmr.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [KEXEC][2.5.63] Partially tested patches available
References: <Pine.LNX.3.96.1030228085058.25875B-100000@gatekeeper.tmr.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Feb 2003 10:03:20 -0700
In-Reply-To: <Pine.LNX.3.96.1030228085058.25875B-100000@gatekeeper.tmr.com>
Message-ID: <m1smu8l4mf.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

> On 27 Feb 2003, Eric W. Biederman wrote:
> 
> 
> > We need to get up some steam and see what it will take for Linus
> > to notice and actually get this patch included.
> 
> I hate to say it, but "notice" and "include" are two different things. He
> noticed the "write oops to disk" feature, he just didn't like it. Linus is
> a great developer, but he has limited sys admin experience, if any. 
> Hopefully he will think it's cool, but don't assume that if you can get
> his attention he will respond as you wish. 

The code has already gotten tentative approval from Linus.  And I suspect
the biggest reason it isn't in is that I have gotten distracted lately
and have not been asking for it to be included.

Being able to use this for processing panics is one of the side features
of kexec.  Admittedly one of the more useful ones, but definitely not a core
feature.

Given the encouragement I have received until I actually get negative
feedback from Linus I will continue to figure it has not made it into
the kernel because Linus has limited hours in the day, and an overflowing
inbox.

Eric
