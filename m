Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316244AbSEVQ6f>; Wed, 22 May 2002 12:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316252AbSEVQ6e>; Wed, 22 May 2002 12:58:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45586 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316244AbSEVQ6c>; Wed, 22 May 2002 12:58:32 -0400
Date: Wed, 22 May 2002 18:58:34 +0200
From: Jan Kara <jack@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Russell King <rmk@arm.linux.org.uk>, jack@suse.cz,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
Message-ID: <20020522165834.GD12982@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.44.0205220901430.7580-100000@home.transmeta.com> <3CEBB385.5040904@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Uz.ytkownik Linus Torvalds napisa?:
> >
> >On Wed, 22 May 2002, Russell King wrote:
> >
> >>/proc/sys has a clean and clear purpose.
> >
> >
> >Yes, but it _:would_ be good to make the quota stuff use the existign
> >helper functions to make it much cleaner.
> >
> >And some of those helper functions are definitely from sysctl's: splitting
> >up the quota file into multiple sysctls (_and_ moving it to /proc/sys/fs)
> >sounds like a good idea to me.
> 
> Well I'm actually coding this right now :-).
  Thanks. I'll update quota tools to use your new files if you send me
new layout of interface...

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
