Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUJZU3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUJZU3P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbUJZU1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:27:19 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:21391 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261439AbUJZU0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 16:26:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=l5d1qV+6ZtJ2CE3TGUq5C9q6Pm5T+BysKj9H62pOwWxNJoZ4csazRrfqoVc9Fvt7moyhALhewkNsoYAlSTakNVC4JI/4sNbkIxJTkXzlA2dBIJwPmI0J/vx5ObS4YWzGAYYILsdJwOIGqtvhDeMEZw5Rze3t7JLPoWqpWXxwIn0=
Message-ID: <4d8e3fd30410261326741a809@mail.gmail.com>
Date: Tue, 26 Oct 2004 22:26:40 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Let's make a small change to the process
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>, alan@lxorguk.ukuu.org.uk,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041026202224.GE15367@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200410260644.47307.edt@aei.ca>
	 <00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin>
	 <4d8e3fd3041026050823d012dc@mail.gmail.com>
	 <877jpdcnf5.fsf@barad-dur.crans.org>
	 <4d8e3fd304102613165b2fb283@mail.gmail.com>
	 <20041026202224.GE15367@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004 13:22:24 -0700, William Lee Irwin III
<wli@holomorphy.com> wrote:
> On Tue, Oct 26, 2004 at 10:16:08PM +0200, Paolo Ciarrocchi wrote:
> 
> 
> > despite I know you are all bored with the " I know how to improve the
> > process" email but I want to share with you this idea .-)
> > Both Andrew and Linus are doing an impressive job so I really don't
> > think we need to change the way they are working.
> > What I'm suggesting is start offering 2.6.X:Y kernel, you did for
> > 2.6.8.1 so...
> > The .Y patchset contains only important security fix (all stuff you
> > think are important) and is weekly uploaded to kernel.org
> > Doing that, people:
> > -  can stop running "personal version of vanilla kernel
> > -  don't need to wait till next Linus' release in order to have a
> > security bug fixed
> > We, of course, need a maintainer for it,
> > maybe someone from OSDL (Randy?), maybe wli (he maintained his tree
> > for a long time), maybe Alan (that is already applying these kind of
> > fixes to his tree), maybe someone else... ?
> > Sounds reasonable ?
> 
> Not normally the first thing I'd volunteer for. I probably won't at
> all unless demand comes down from on high.

Well, I wrote your name because you are a great developer but I
understand you prefer doing something else ;)

What about just the *idea* ?

-- 
Paolo
