Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261776AbSJDOC2>; Fri, 4 Oct 2002 10:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261775AbSJDOC2>; Fri, 4 Oct 2002 10:02:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36624 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261774AbSJDOCY>; Fri, 4 Oct 2002 10:02:24 -0400
Date: Fri, 4 Oct 2002 15:07:52 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Subject: Re: RAID backup
Message-ID: <20021004150752.B16727@flint.arm.linux.org.uk>
References: <Pine.LNX.3.96.1021004041421.5688A-100000@Maggie.Linux-Consulting.com> <1033735943.31839.12.camel@irongate.swansea.linux.org.uk> <20021004132419.GF710@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021004132419.GF710@gallifrey>; from gilbertd@treblig.org on Fri, Oct 04, 2002 at 02:24:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 02:24:19PM +0100, Dr. David Alan Gilbert wrote:
> Not sure about that; DLT tapes are pretty bulky themselves; I think the
> difference between say a set of 4 DLT tapes and a single Maxtor 320 in
> caddy would be minimal.

The 4 DLT tapes would take up twice the room.

> As for stored media, I think Maxtor are quoting
> 1M hours MTTF - (I hate to think how you measure such a figure) - for
> the 320G, and that is probably longer than I'd trust either the tape or
> the drive to survive.

However, drive in caddy or no caddy, the accidental drop test would
probably be more favourable to the DLT tape surviving over the drive.
Physical accidents do happen.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

