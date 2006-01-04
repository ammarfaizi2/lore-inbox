Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWADUKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWADUKg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbWADUKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:10:35 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:19846 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751591AbWADUKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:10:34 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Nick Warne <nick@linicks.net>
Subject: Re: 2.6.14.5 to 2.6.15 patch
Date: Wed, 4 Jan 2006 20:10:36 +0000
User-Agent: KMail/1.9
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org, webmaster@kernel.org
References: <200601041710.37648.nick@linicks.net> <200601041834.23722.s0348365@sms.ed.ac.uk> <200601041953.15735.nick@linicks.net>
In-Reply-To: <200601041953.15735.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601042010.36208.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 19:53, Nick Warne wrote:
> On Wednesday 04 January 2006 18:34, Alistair John Strachan wrote:
> > On Wednesday 04 January 2006 17:39, Nick Warne wrote:
> > > On Wednesday 04 January 2006 17:36, Randy.Dunlap wrote:
> > > > > I went from 2.6.14 -> 2.6.14.2 -> .2-.3 -> .3-.4 -> .4-.5
> > > >
> > > > and how did you do that?
> > > > Noone supplies such incremental patches AFAIK.
> > >
> > > Yes, I got from kernel.org - I am _not_ that clever to devise my own
> > > incremental patches, otherwise I wouldn't be asking stupid questions...
> >
> > Nick's right, both are provided automatically by kernel.org.
>
> Anyway, I started from scratch - 2.6.14, patched to 2.6.15 and then make
> oldconfig etc.
>
> I think there needs to be a way out of this that is easily discernible - it
> does get confusing sometimes with all the patches flying around on a
> 'stable release'.

It's documented in the kernel.

There's something in the kernel.org FAQ there about -rc kernels, but it might 
be better to generalise this for stable releases. Added hpa to CC.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
