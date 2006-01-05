Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWAEPmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWAEPmw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWAEPi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:38:28 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:9455 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932097AbWAEPhy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:37:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FF42bRn/liwodvq0hgnRpEAFhJT3IikiO7wh4bYsOktdrR1yodMA896vuEiBf0M0WMZKjmIcnPWeiO03X9dQG9Se8Qtwcx3/NnzjHJehAF8FEGdl4Fs+SDRxhhnXbD+HsgGlBV2nHNRF9E+sgj0YC+IjgINTnTcBts8XOYyhr0s=
Message-ID: <9a8748490601050737y24f04505hb605fbe96fe4f92c@mail.gmail.com>
Date: Thu, 5 Jan 2006 16:37:53 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: 2.6.14.5 to 2.6.15 patch
Cc: "H. Peter Anvin" <hpa@zytor.com>, Greg KH <greg@kroah.com>,
       Nick Warne <nick@linicks.net>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, webmaster@kernel.org
In-Reply-To: <200601051525.05613.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601041710.37648.nick@linicks.net>
	 <200601042249.12116.s0348365@sms.ed.ac.uk>
	 <43BC636D.3070109@zytor.com>
	 <200601051525.05613.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/06, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> On Thursday 05 January 2006 00:08, H. Peter Anvin wrote:
> > Alistair John Strachan wrote:
> > > Re-read the thread. The confusion here is about "going back" to 2.6.14
> > > before patching 2.6.15. This has nothing to do with "rc kernels". We have
> > > this documented explicitly in the kernel but not on the kernel.org FAQ.
> >
> > If you can send me some suggested verbiage I'll put it in the FAQ.  We
> > can also make a page that's directly linked from the "stable release",
> > kind of like we have info links for -mm patches etc.
>
> I hope somebody else here can minimise my logic; I think the verbosity is
> necessary to completely explain the "patch nightmare" to everybody concerned.
>
[snip]

Nice writeup, but why not simply put a copy of
Documentation/applying-patches.txt online and link to that?
It contains more or less the same stuff you just wrote.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
