Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289099AbSBMXMT>; Wed, 13 Feb 2002 18:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289096AbSBMXMK>; Wed, 13 Feb 2002 18:12:10 -0500
Received: from melancholia.rimspace.net ([210.23.138.19]:32268 "EHLO
	melancholia.danann.net") by vger.kernel.org with ESMTP
	id <S289098AbSBMXLt>; Wed, 13 Feb 2002 18:11:49 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What does AddrMarkNotFound mean?
In-Reply-To: <E16b8Ab-0006f6-00@the-village.bc.nu>
In-Reply-To: <E16b8Ab-0006f6-00@the-village.bc.nu> (Alan Cox's message of
 "Wed, 13 Feb 2002 22:46:33 +0000 (GMT)")
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
Date: Thu, 14 Feb 2002 10:11:37 +1100
Message-ID: <871yfpf046.fsf@inanna.rimspace.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.5 (bamboo,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Alan Cox wrote:
>> Is this typical behavior for a hard drive which has developed bad
>> blocks?  And if I blacklist the affected blocks in the filesystem,
>> should I also blacklist a few previous blocks in order to avoid
>> problems with the readahead feature of the IDE drivers?
> 
> Its a disk error (it can't find the index marks for a sector). In
> general its a bad sign and you might want to check the smart data for
> the disk.
> 
> If you bought an IBM disk within the last 18 months or so check for
> new firmware, flash it if so and reformat it before panicing and
> assuming the worst.

Having done precisely that, and ended up owning an IBM hard drive that
has hit exactly this problem, like so many before this, this firmware
upgrade idea is rather appealing. It would be nice to be able to trust
the drive...

...but I can't seem to find the firmware anywhere on the IBM storage
site or, in fact, anywhere.  Have you any hints as to where I might
look?

It's a DTLA-307030, made in Hungary, if that makes it easier to help. :)

Thanks,
        Daniel

-- 
What was once called the objective world is a sort of Rorschach ink blot,
into which each culture, each system of science and religion, each type of
personality, reads a meaning only remotely derived from the shape and color
of the blot itself.
        -- Lewis Mumford
