Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262060AbSI3Ncl>; Mon, 30 Sep 2002 09:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262058AbSI3Ncl>; Mon, 30 Sep 2002 09:32:41 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:34715 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262060AbSI3Nck>; Mon, 30 Sep 2002 09:32:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Michael Clark <michael@metaparadigm.com>,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: v2.6 vs v3.0
Date: Mon, 30 Sep 2002 08:05:57 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <200209290114.15994.jdickens@ameritech.net> <20020929214652.GF12928@merlin.emma.line.org> <3D97F7AE.5070304@metaparadigm.com>
In-Reply-To: <3D97F7AE.5070304@metaparadigm.com>
MIME-Version: 1.0
Message-Id: <02093008055700.15956@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 September 2002 02:05, Michael Clark wrote:
> On 09/30/02 05:46, Matthias Andree wrote:
> >
> > Is not EVMS ready for the show? Is Linux >=2.6 going to have LVM2 and
> > EVMS? Or just LVM2? I'm not aware of the current status, but I do recall
> > having seen EVMS stable announcements (but not sure about 2.5 status).
>
>  From reading the EVMS list, it was working with 2.5.36 a couple weeks
> ago but needs some small bio and gendisk changes to work in 2.5.39.
>
> http://sourceforge.net/mailarchive/forum.php?thread_id=1105826&forum_id=2003
>
> CVS version may be up-to-date quite soon from reading the thread.
> It seems to be further along in 2.5 support than LVM2 - also including
> the fact that EVMS supports LVM1 metadata (which the 2.5 version of LVM2
> may not do so quite so soon from mentions on the lvm list).
>
> I haven't tried EVMS but certainly from looking at the feature set,
> it looks more comprehensive and modular than LVM (with its support
> for multiple metadata personalities).
>
> I too have LVM on quite a few of my machines, including my desktop,
> and if I wanted to test 2.5 right now - i'd probably have to do it
> using EVMS.

EVMS is now up-to-date and running on 2.5.39. You can get the latest kernel 
code from CVS (http://sourceforge.net/cvs/?group_id=25076) or Bitkeepr 
(http://evms.bkbits.net/). There will be a new, full release (1.2) coming out 
this week.

Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
