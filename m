Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276249AbRJaX6Z>; Wed, 31 Oct 2001 18:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276424AbRJaX6W>; Wed, 31 Oct 2001 18:58:22 -0500
Received: from marine.sonic.net ([208.201.224.37]:2665 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S276249AbRJaX5E>;
	Wed, 31 Oct 2001 18:57:04 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Wed, 31 Oct 2001 15:57:29 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: cdrecord from ext3
Message-ID: <20011031155728.G1767@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011031001846.A1840@werewolf.able.es> <3BDF576F.3A797933@zip.com.au> <20011031155934.A18608@werewolf.able.es> <9rpdp8$601$1@cesium.transmeta.com> <20011031104000.D1767@thune.mrc-home.com> <20011031174030.E6992@0xd6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011031174030.E6992@0xd6.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 05:40:30PM -0600, M. R. Brown wrote:
> * Mike Castle <dalgoda@ix.netcom.com> on Wed, Oct 31, 2001:
> > So unmount and remount as ext2?
> > 
> 
> ext2 == ext3
> 
> What you'd want to do is do the first test on a vanilla ext2 partition, and
> then perform the second test on that same partition, mounted as ext3.  That
> way you aren't being slowed down by physical properties of the drive.

That's what I said, just not in so many words.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
