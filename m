Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265103AbSJaCJ2>; Wed, 30 Oct 2002 21:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265104AbSJaCJ2>; Wed, 30 Oct 2002 21:09:28 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:59564 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265103AbSJaCJ1>;
	Wed, 30 Oct 2002 21:09:27 -0500
Message-ID: <3DC09152.10502@us.ibm.com>
Date: Wed, 30 Oct 2002 18:11:30 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Rival <frival@zk3.dec.com>
CC: Anton Blanchard <anton@samba.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] use asm-generic/topology.h
References: <3DC056C2.4070609@us.ibm.com> <20021030233107.GB4820@krispykreme> <3DC06CAE.8040806@us.ibm.com> <3DC08A9C.F5B267A8@zk3.dec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Rival wrote:
>
 > <snip>
> 
> I'd say six of one, half-dozen of the other.  I've been working with another
> engineer on updated patches that among other things make NUMA work on Alpha
> again.  We're also re-working much of the surrounding code, including much of
> this file anyway - Marvel uses a much different topology than Wildfire.
> 
> It looks fine to me, but realistically the only opinion I can give for real is
> a shoulder shrug, as I'm not exactly sure when the code will be ready for
> submission.  Actually, the patch looks just like a part of the patch we have
> working, just without Marvel support.  Then again, I suppose IBM would have a
> hard time doing that, huh? ;)

I'll take that as a thumbs-up.  "A wink's as good as a nudge to a blind 
bat!  eh? EH?"

Please apply, Linus.

Oh yeah...  If you want to send me free hardware to play with, we can 
see what happens on the Marvel support front...  ;) ;)

Cheers!

-Matt

