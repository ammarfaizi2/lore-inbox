Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282214AbRKWUA2>; Fri, 23 Nov 2001 15:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282215AbRKWUAT>; Fri, 23 Nov 2001 15:00:19 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:57733 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S282214AbRKWUAM>;
	Fri, 23 Nov 2001 15:00:12 -0500
Message-ID: <3BFEAAC4.23265EF7@pobox.com>
Date: Fri, 23 Nov 2001 12:00:04 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.15-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Frost <sfrost@snowman.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: is 2.4.15 really available at www.kernel.org?
In-Reply-To: <20011123110505.A27707@alcove.wittsend.com> <Pine.LNX.3.96.1011123102729.32257D-100000@mandrakesoft.mandrakesoft.com> <20011123122527.A13163@alcove.wittsend.com> <20011123141916.Y481@ns>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Frost wrote:

> * Michael H. Warfield (mhw@wittsend.com) wrote:
> > On Fri, Nov 23, 2001 at 10:27:45AM -0600, Jeff Garzik wrote:
> > > On Fri, 23 Nov 2001, Michael H. Warfield wrote:
> > > >   Point is that it BROKE some things....  Like "make install" on
> > > > RedHat installed the damn thing as /boot/vmlinuz-2.4.15-greased-turkey,
> > > > breaking the lilo settings if you set an image for "vmlinuz-2.4.15"
> > > > like you expected it to be.  Not funny.  Just had three freeswan
> > > > kinstall builds blow up because of that.
> >
>         Uh, so don't make assumptions on what the kernel rev. is going
>         to be?  It's not that hard to figure it out from the Makefile.
>
>                 Stephen

Or, better yet, a quick glance at /lib/modules?

cu

jjs

