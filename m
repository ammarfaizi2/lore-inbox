Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269463AbRHTVhG>; Mon, 20 Aug 2001 17:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269428AbRHTVg4>; Mon, 20 Aug 2001 17:36:56 -0400
Received: from mercury.is.co.za ([196.4.160.222]:44041 "HELO mercury.is.co.za")
	by vger.kernel.org with SMTP id <S269436AbRHTVgr>;
	Mon, 20 Aug 2001 17:36:47 -0400
Date: Mon, 20 Aug 2001 23:37:18 +0200
From: Dewet Diener <linux-kernel@dewet.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Riley Williams <rhw@MemAlpha.CX>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 partition unmountable
Message-ID: <20010820233718.A10130@darkwing.flatlit.net>
In-Reply-To: <20010818235211.A24646@darkwing.flatlit.net> <Pine.LNX.4.33.0108182257490.9206-100000@infradead.org> <20010820191046.D4389@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010820191046.D4389@redhat.com>; from sct@redhat.com on Mon, Aug 20, 2001 at 07:10:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2001 at 07:10:46PM +0100, Stephen C. Tweedie wrote:
> >  > I'll probably have to take the drive back, and see if it now mounts
> >  > in the original system :-/
> > 
> > That might help...
> 
> Indeed, I'd like to see what that gives you.

Well, haven't had a chance to stick it in again, but after I repaired 
it with e2fsck off a backup superblock, I'm assuming it will work fine...

> One quick question: are either of the machines big-endian (HPPA, PPC
> etc)?

Nope, just plain PIII and AMD :)

> Cheers, 
>  Stephen

Regards,
Dewet
