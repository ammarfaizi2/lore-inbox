Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281467AbRKHIL2>; Thu, 8 Nov 2001 03:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281468AbRKHILT>; Thu, 8 Nov 2001 03:11:19 -0500
Received: from [208.48.139.185] ([208.48.139.185]:50392 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S281467AbRKHILA>; Thu, 8 Nov 2001 03:11:00 -0500
Date: Thu, 8 Nov 2001 00:10:54 -0800
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Suspected bug - System slowdown under unexplained excessive disk I/O - 2.4.13
Message-ID: <20011108001054.A10029@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011107221148.A7828@greenhydrant.com> <Pine.LNX.4.40.0111080841130.12597-100000@omega.hbh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0111080841130.12597-100000@omega.hbh.net>; from oktay.akbal@s-tec.de on Thu, Nov 08, 2001 at 08:45:12AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 08:45:12AM +0100, Oktay Akbal wrote:
> On Wed, 7 Nov 2001, David Rees wrote:
> 
> > >
> > > Keywords:
> > >
> > > vm, ReiserFS, heavy disk I/O,
> >
> > Let me guess, IDE disks?  Anyway, this is a FAQ.  Go www.namesys.com, click
> > on the FAQ, and look at #15.
> 
> To bad I did not see the Reiserfs-Keyword before asking...
> In my case this happened on scsi-disks on a adaptec 2940.
> I read the faq-entry, but I do not understand why this should only apply
> to IDE. Maybe my old-scsi disks suffer the same problem ?

It could affect certain SCSI disks/controllers just as well.  You might want
to ask this question on the reiserfs list to see if they have any
solutions...

-Dave
