Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271810AbRH3Vfr>; Thu, 30 Aug 2001 17:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271671AbRH3Vfh>; Thu, 30 Aug 2001 17:35:37 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:3848 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S271364AbRH3Vfb>; Thu, 30 Aug 2001 17:35:31 -0400
Message-ID: <3B8EB1AE.83C7515B@namesys.com>
Date: Fri, 31 Aug 2001 01:35:42 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs: how to mount without journal replay?
In-Reply-To: <20010826130858.A39@toy.ucw.cz> <15246.11218.125243.775849@gargle.gargle.HOWL> <20010830225323.A18630@atrey.karlin.mff.cuni.cz> <20010830143055.B6933@mikef-linux.matchmail.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> On Thu, Aug 30, 2001 at 10:53:23PM +0200, Pavel Machek wrote:
> >
> > No stack trace, sorry. It refused to mount saying that attempting to
> > write into log block.. That's panic. Reiserfsck is not usable in such
> > case, because ... how do you run reiserfsck from partition you can't
> > mount?
> >                                                               Pavel
> 
> And how do you deal with that situation on xfs, ext3, or any other journaled
> fs?  I don't think it even needs to be journaled at all.
> 
> If you have a broken ext2, and can't mount root, you're screwed until you
> put it in another system to fix it...
> 
> Mike
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


I think that life has gotten way easier now that distros can mostly be rescued
using CDROMs instead of floppies.

:)

Hans
