Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316571AbSFPUob>; Sun, 16 Jun 2002 16:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316572AbSFPUob>; Sun, 16 Jun 2002 16:44:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11283 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316571AbSFPUo3>; Sun, 16 Jun 2002 16:44:29 -0400
Date: Sun, 16 Jun 2002 22:44:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ducrot Bruno <poup@poupinou.org>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       ducrot@poupinou.org
Subject: Re: S4bios support
Message-ID: <20020616204433.GB2147@atrey.karlin.mff.cuni.cz>
References: <20020612192820.GA114@elf.ucw.cz> <20020614171429.GA5331@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020614171429.GA5331@poup.poupinou.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jun 12, 2002 at 09:28:21PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > I ported s4bios support to 2.5.21 and make it somehow work on my
> > machine. It suspend, resumes (with nice graphics ;-), but kernel does
> > not wake up devices properly. If someone wants to play...
> 
> What kind of issues you got ?

Lockup on awake.

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
