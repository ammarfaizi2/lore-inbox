Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286330AbRLTSm7>; Thu, 20 Dec 2001 13:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286337AbRLTSmu>; Thu, 20 Dec 2001 13:42:50 -0500
Received: from [206.124.139.154] ([206.124.139.154]:56327 "EHLO
	grieg.holmsjoen.com") by vger.kernel.org with ESMTP
	id <S286330AbRLTSmj>; Thu, 20 Dec 2001 13:42:39 -0500
Date: Thu, 20 Dec 2001 10:42:26 -0800
From: Randolph Bentson <bentson@grieg.holmsjoen.com>
To: Matt Bernstein <matt@theBachChoir.org.uk>
Cc: Steven Cole <scole@lanl.gov>, esr@thyrsus.com,
        linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
Message-ID: <20011220104226.A5716@grieg.holmsjoen.com>
In-Reply-To: <200112201721.KAA05522@tstac.esa.lanl.gov> <Pine.LNX.4.43.0112201810340.16545-100000@nick.dcs.qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.43.0112201810340.16545-100000@nick.dcs.qmul.ac.uk>; from matt@theBachChoir.org.uk on Thu, Dec 20, 2001 at 06:16:24PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 06:16:24PM +0000, Matt Bernstein wrote:
> I believe that the main purpose of documentation, help etc is to get the
> information across in a way that is most easily understood, ie that
> minimises the number of support questions.. ..and everyone surely knows
> what GB, MB and KB stand for. So let's leave it at that. Where's the "i"
> in "megabyte" ? Or is 1MiB 1000000 bytes, rather than 1048576?
> 
> It's confusing enough with the 10 "Mb" networking / 1.44 "MB" floppy
> distinction already..

I'm afraid I have to disagree with you.  Not enough people
know that KB stands for 1000B.  I know through experience that
KB is often used for 1024B.  The introduction of KiB makes it
clear that 1024B is intended.

-- 
Randolph Bentson
bentson@holmsjoen.com
