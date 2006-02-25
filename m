Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWBYCTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWBYCTb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 21:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWBYCTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 21:19:31 -0500
Received: from mail.gmx.de ([213.165.64.20]:45199 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932361AbWBYCTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 21:19:31 -0500
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-rc4-mm1]  Task Throttling V14
From: MIke Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, kernel@kolivas.org,
       pwil3058@bigpond.net.au, nickpiggin@yahoo.com.au,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
In-Reply-To: <20060224141505.41b1a627.akpm@osdl.org>
References: <1140183903.14128.77.camel@homer>
	 <1140812981.8713.35.camel@homer>  <20060224141505.41b1a627.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 25 Feb 2006 03:23:10 +0100
Message-Id: <1140834190.7641.25.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-24 at 14:15 -0800, Andrew Morton wrote:
> MIke Galbraith <efault@gmx.de> wrote:
> >
> > Not many comments came back, zero actually.
> >
> 
> That's because everyone's terribly busy chasing down those final bugs so we
> get a really great 2.6.16 release (heh, I kill me).
> 
> I'm a bit reluctant to add changes like this until we get the smpnice stuff
> settled down and validated.

I agree 100% on all counts.  If this, or even something like it, is
considered, it absolutely does need testing without other flavors in the
soup.

	-Mike

