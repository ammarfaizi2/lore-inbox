Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317503AbSFKSjO>; Tue, 11 Jun 2002 14:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317506AbSFKSjN>; Tue, 11 Jun 2002 14:39:13 -0400
Received: from [212.234.165.220] ([212.234.165.220]:25658 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S317503AbSFKSjM>; Tue, 11 Jun 2002 14:39:12 -0400
Date: Tue, 11 Jun 2002 19:39:40 +0200
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] device_suspend() / device_resume() on S1?
Message-ID: <20020611173940.GF18047@poup.poupinou.org>
In-Reply-To: <20020608214034.GA163@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2002 at 11:40:34PM +0200, Pavel Machek wrote:
> Hi!
> 
> Should we do device_suspend / device_resume on acpi S1 transition?
> 
> Con: It is not needed according to specs.
> 
> Con: It is more complicated that way.
> 
> Pro: Many buggy notebooks will probably need it.

Pro: without it, my laptop didn't survive :)

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
