Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136723AbRECKhD>; Thu, 3 May 2001 06:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136708AbRECKgx>; Thu, 3 May 2001 06:36:53 -0400
Received: from femail1.sdc1.sfba.home.com ([24.0.95.81]:26616 "EHLO
	femail1.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S136727AbRECKgf>; Thu, 3 May 2001 06:36:35 -0400
Message-ID: <3AF134AE.1B6DBDA8@home.com>
Date: Thu, 03 May 2001 03:36:30 -0700
From: Seth Goldberg <bergsoft@home.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Leete <tleete@mountain.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Followup to previous post: Atlon/VIA Instabilities
In-Reply-To: <3AEE9EA0.3752F0C0@home.com> <3AEFEB0E.1C464EA9@mountain.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

  Nope.  No emulation here. Thanks for trying tho ;).

 --Seth

Tom Leete wrote:
> 
> Seth Goldberg wrote:
> >
> > Hi,
> >
> >   So it seems that CONFIG_X86_USE_3DNOW is simply used to
> > enable access to the routines in mmx.c (the athlon-optimized
> > routines on CONFIG_K7 kernels), so then it appears that somehow
> > this is corrupting memory / not behaving as it should (very
> > technical, right?) :)...
> >
> >  --Seth
> 
> This is a shot in the dark. Do you have floating-point emulation on
> (CONFIG_MATH_EMULATION=y)?
> 
> Tom
> 
> --
> The Daemons lurk and are dumb. -- Emerson
