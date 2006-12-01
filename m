Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162046AbWLAWAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162046AbWLAWAO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 17:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162022AbWLAWAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 17:00:14 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:24425 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1162053AbWLAWAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 17:00:12 -0500
From: Dmitry Mishin <dim@openvz.org>
Organization: SWsoft
To: devel@openvz.org
Subject: Re: [Devel] Re: Linux 2.6.19 VServer 2.1.x
Date: Sat, 2 Dec 2006 00:59:47 +0300
User-Agent: KMail/1.9.4
Cc: Herbert Poetzl <herbert@13thfloor.at>, Kirill Korotaev <dev@sw.ru>,
       Linux Containers <containers@lists.osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20061201022904.GP2826@MAIL.13thfloor.at> <457004DF.7030100@sw.ru> <20061201193230.GA544@MAIL.13thfloor.at>
In-Reply-To: <20061201193230.GA544@MAIL.13thfloor.at>
X-Face: 'h\woBm&GL5>q=4~&$7\8J0Sv3c2a98rBl,dx/@?L4)Tg!C-nz4]2>M>=?utf-8?q?6ZwpyJ=7Ek=7EqqVT-=0A=09=7CIm?=(,W)U}CZo`G#(&OpK?El5u#-mi~%Uo)?X/qE[LE-H88#x'Y<GId$mZ]i%"iG|<=?utf-8?q?Zm/4u=0A=09Ld=2E=23=5B/Am=7D=5DV10UW0qjZUu7?=@;6SQI%Uy^H
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612020059.48170.dim@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 December 2006 22:32, Herbert Poetzl wrote:
> On Fri, Dec 01, 2006 at 01:33:03PM +0300, Kirill Korotaev wrote:
> > OpenVZ has been using them for more than a month already ;-)
>
> great for you, here some details:
>
>  - 2.6.19 was released 29th Nov 2006
>  - OpenVZ page shows 2.6.9-023, 2.6.16 and the
>    2.6.18 development
>  - Linux-VServer has followed the -rc series
>    too, so that's nothing new
>  - I didn't manage to find an OpenVZ patch for
>    2.6.19 on your site
>
> but probably all the changes from 2.6.19 have
> been backported to the stable 2.6.9 kernel
> several months ago :)
more details:
http://git.openvz.org/?p=linux-2.6.18-openvz;a=commitdiff;h=2563d54c8c3215792af24d96d852fe30aed2a7b4
http://git.openvz.org/?p=linux-2.6.18-openvz;a=commitdiff;h=44100ee643f4f59e8b71ac10b7b5f01f8a423292

>
> best,
> Herbert
>
> > Kirill
> >
> > > Ladies and Gentlemen!
> > >
> > > here is the first Linux-VServer version (testing)
> > > with support for the *spaces (uts, ipc and vfs)
> > > introduced in 2.6.19 ...
> > >
> > > http://vserver.13thfloor.at/Experimental/patch-2.6.19-vs2.1.x-t1.diff
> > >
> > > it might not be as perfect as the kernel itself *G*
> > > but it does work fine here, and with recent tools
> > > most virtualization features work as expected
> > >
> > > please if you do testing, report issues or comments
> > > to the Linux-VServer mailing list or to me directly
> > > (at least CC would be fine) and do not bother the
> > > nice kernel folks ...
> > >
> > > enjoy,
> > > Herbert
> > > _______________________________________________
> > > Containers mailing list
> > > Containers@lists.osdl.org
> > > https://lists.osdl.org/mailman/listinfo/containers
>
> _______________________________________________
> Containers mailing list
> Containers@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/containers
>
> _______________________________________________
> Devel mailing list
> Devel@openvz.org
> https://openvz.org/mailman/listinfo/devel

-- 
Thanks,
Dmitry.
