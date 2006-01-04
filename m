Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWADXAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWADXAp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWADXAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:00:44 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:7881 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751052AbWADXAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:00:44 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.14.5 to 2.6.15 patch
Date: Wed, 4 Jan 2006 22:58:24 +0000
User-Agent: KMail/1.9
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Nick Warne <nick@linicks.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       webmaster@kernel.org
References: <200601041710.37648.nick@linicks.net> <Pine.LNX.4.58.0601041415510.19134@shark.he.net> <20060104223101.GB13799@kroah.com>
In-Reply-To: <20060104223101.GB13799@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601042258.24888.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 22:31, Greg KH wrote:
[snip]
> > >
> > > The issue I hit was we have a 'latest stable kernel release 2.6.14.5'
> > > and under it a 'the latest stable kernel' (or words to that effect) on
> > > kernel.org.
> > >
> > > Then when 2.6.15 came out, that was it!  No patch for the 'latest
> > > stable kernel release 2.6.14.5'.  It was GONE!
> >
> > Yes, I brought this up a couple of weeks ago, but I was told
> > that I was wrong (in some such words).
> > I agree that it needs to be fixed.
>
> How would you suggest that it be fixed?

It's difficult, but perhaps providing a link to the latest "stable team" 
release in addition to Linus's release would solve the problem.

At least then you can do what Nick wanted (assuming the kernel.org FAQ gets 
fixed) and download the "patch" for 2.6.14.5, say, revert it, then apply 
Linus's latest and greatest (one or more times as required).

Bloats the front page though. I think as long as something is documented 
properly it doesn't really matter. Currently it isn't.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
