Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281553AbRKUBEF>; Tue, 20 Nov 2001 20:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281554AbRKUBDz>; Tue, 20 Nov 2001 20:03:55 -0500
Received: from freeside.toyota.com ([63.87.74.7]:17674 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S281553AbRKUBDo>; Tue, 20 Nov 2001 20:03:44 -0500
Message-ID: <3BFAFD65.9930EE18@lexus.com>
Date: Tue, 20 Nov 2001 17:03:33 -0800
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.15-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
CC: "Ryan M. McConahy" <jfanonymous@yahoo.com>,
        Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
Subject: Re: Loop.c File !!!!
In-Reply-To: <Pine.LNX.4.21.0111202025290.6299-100000@brick>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ryan M. McConahy" wrote:

> On Tue, 20 Nov 2001, Miguel Maria Godinho de Matos wrote:
>
> > The problem is the following:
> >
> > Some one told me i should edit the loop.c file and even tried to explained me
> > why but i couldn't understand.
> >
> > He said something about my new kernel wouldn't be able to compile if two or
> > three lines weren't comented!
> >
> > I didn't understand this fact so i would like to know why should i edit the
> > /usr/src/linux/drivers/block/loop.c file!!!!
>
> What lines did he want you to comment out? Tell us more! I don't think you
> would need to.

He's doubtless referring to the deactivate_page()
thing that's been talked to death on this list for
the past 2 weeks...

Better solution is go to 2.4.15-pre7, which has
fixes for that and many other things as well -

Then again, it sure looks like 2.4.15-final is RSN.

cu

jjs

