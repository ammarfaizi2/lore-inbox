Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265898AbUGMUym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265898AbUGMUym (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 16:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbUGMUyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 16:54:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:35214 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265898AbUGMUyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 16:54:31 -0400
Date: Tue, 13 Jul 2004 13:54:02 -0700
From: cliff white <cliffw@osdl.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: bunk@fs.tum.de, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.8-rc1
Message-Id: <20040713135402.388af231.cliffw@osdl.org>
In-Reply-To: <4d8e3fd304071208566280e89b@mail.gmail.com>
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
	<4d8e3fd3040712023469039826@mail.gmail.com>
	<20040712154204.GS4701@fs.tum.de>
	<4d8e3fd304071208566280e89b@mail.gmail.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004 17:56:14 +0200
Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:

[snip]
> I agree.
> 
> > OSDL does some tests for any -rc and many other people like me do other
> > testing. Besides this, most patches already got similar treatment in
> > -mm. This might not be a base for an ISO 9000 certificate, but it seems
> > to be sufficietely working for finding most problems before the acttual
> > release.
> 
> OSDL does some test for any -rc but the results of these tests don't affect
> the release process. At least not in an official way.
>  
> > It would be more important if Linus would release one last -rc that will
> > be released unchanged (except for EXTRAVERSION a few days later to catch
> > bugs in last minute changes. This might catch more problems like the JFS
> > compile problem in 2.6.7.
> 
> Right,
> and in those days may be OSDL could run the testsuite we are discussing about.

We do run bunches of tests, but we are generally way behind in actually looking
and analysing the results of those tests - which makes it hard for us to help the
development much.  Any body that wishes to help particpate
in OSDL testing, come on down! We're at stp-devel@lists.sourceforge.net
cliffw


> 
> ciao, Paolo
>  
> -- 
> paoloc.doesntexist.org
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
