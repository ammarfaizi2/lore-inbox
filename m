Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261362AbSJYKLJ>; Fri, 25 Oct 2002 06:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSJYKLJ>; Fri, 25 Oct 2002 06:11:09 -0400
Received: from host145.south.iit.edu ([216.47.130.145]:57988 "EHLO
	lostlogicx.com") by vger.kernel.org with ESMTP id <S261362AbSJYKLE>;
	Fri, 25 Oct 2002 06:11:04 -0400
Date: Fri, 25 Oct 2002 05:17:05 -0500
From: Brandon Low <lostlogic@gentoo.org>
To: Ian Leonard <ileonard@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HPT372 on Abit KD7 motherboard
Message-ID: <20021025051705.A13079@lostlogicx.com>
References: <20021025101504.GE13280@dino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021025101504.GE13280@dino>; from ileonard@ntlworld.com on Fri, Oct 25, 2002 at 11:15:04AM +0100
X-Operating-System: Linux found 2.4.20-pre10-mjc1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the -ac tree.  (that is the long and short of it, until the bigwhig 
hackers start paying attention to 2.4 users again and alan's tree full of 
IDE goodness can be merged into marcelo's tree ;-))

--Brandon
Gentoo Linux Kernel Dude

On Fri, 10/25/02 at 11:15:04 +0100, Ian Leonard wrote:
> Greetings,
> 
> I am trying to get the hpt372 ide to work (not as a raid).
> I have tried 2.4.19 and with patch-2.4.20-pre11.
> 
> On boot, 'ide: lost interrupt' is printed, although the hpt372
> is detected.  Partitions on ide can be mounted but soon
> fail with busy errors.
> 
> I tried Highpoints Linux driver. This seems to work but
> uses the scsi interface. Other messages in the archive
> suggest that the 372 should work.
> 
> Anybody got this to work?
> 
> TIA.
> 
> --
> Ian Leonard
> eMail: ileonard@ntlworld.com
> Phone: +44 (0)1865 765273
> 
> Please ignore spelling and punctuation - I did.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
