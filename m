Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288263AbSACQyd>; Thu, 3 Jan 2002 11:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288256AbSACQxN>; Thu, 3 Jan 2002 11:53:13 -0500
Received: from dialin-212-144-150-064.arcor-ip.net ([212.144.150.64]:14575
	"EHLO merv") by vger.kernel.org with ESMTP id <S288255AbSACQwm>;
	Thu, 3 Jan 2002 11:52:42 -0500
Date: Thu, 3 Jan 2002 17:53:22 +0100
From: Andreas Bombe <bombe@informatik.tu-muenchen.de>
To: Shaya Potter <spotter@opus.cs.columbia.edu>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Dual athlon XP 1800 problems
Message-ID: <20020103165321.GA737@bombe.modem.informatik.tu-muenchen.de>
Mail-Followup-To: Shaya Potter <spotter@opus.cs.columbia.edu>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C311B00.FFB58648@get2chip.com> <20020101032335.A11129@suse.de> <1009868304.27412.2.camel@zaphod>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1009868304.27412.2.camel@zaphod>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2002 at 01:58:23AM -0500, Shaya Potter wrote:
> I missed the original message, I'm running a dual athlon 1800+ XP system
> (actually both CPU for some reason get identified as MPs, but they are
> retail XP chips).

The identification string is written by the BIOS.  Yours didn't know
about XPs so it misidentified them as MPs.  Upgrade your BIOS if this
bugs you.

If ID string contradicts what you think you bought, don't trust the ID
string.

-- 
Andreas Bombe <bombe@informatik.tu-muenchen.de>    DSA key 0x04880A44
