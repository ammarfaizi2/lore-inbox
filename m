Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWAZOfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWAZOfA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWAZOfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:35:00 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:18051 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932335AbWAZOe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:34:59 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 26 Jan 2006 15:32:27 +0100
To: schilling@fokus.fraunhofer.de, nickpiggin@yahoo.com.au
Cc: rlrevell@joe-job.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, grundig@teleline.es, axboe@suse.de,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D8DD7B.nailE2XL1KRWJ@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
 <20060125144543.GY4212@suse.de>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
 <20060125181847.b8ca4ceb.grundig@teleline.es>
 <43D8988F.nailDTH21LS0G@burner> <1138268759.3087.138.camel@mindpipe>
 <43D8D5A0.nailE2X71H31H@burner> <43D8D80B.9080203@yahoo.com.au>
In-Reply-To: <43D8D80B.9080203@yahoo.com.au>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Joerg Schilling wrote:
> > Lee Revell <rlrevell@joe-job.com> wrote:
> > 
> > 
> >>>Interesting: You claim that the Linux platform provides ways to retrieve 
> >>>the needed information on FreeBSD, MS-WIN, ....?
> >>>
> >>
> >>What do FreeBSD and MS-WIN have to do with Linux?
> > 
> > 
> > What is the relevence of /dev/hd* for a device independent library like libscg?
> > 
>
> Isn't it good practice to adhere to the naming conventions
> of the system to which a program is ported to? (even if 100
> of them do it one way and 1 does it another)

Well, the problem is that (in special if you include the ATAPI tape drives)
Linux likes to enforce inapropriate naming conventions.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
