Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269596AbRHHWOR>; Wed, 8 Aug 2001 18:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269593AbRHHWOH>; Wed, 8 Aug 2001 18:14:07 -0400
Received: from cr545978-a.nmkt1.on.wave.home.com ([24.112.25.43]:59653 "HELO
	saturn.tlug.org") by vger.kernel.org with SMTP id <S269596AbRHHWN4>;
	Wed, 8 Aug 2001 18:13:56 -0400
Date: Wed, 8 Aug 2001 18:14:06 -0400
From: Mike Frisch <mfrisch@saturn.tlug.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon/MSI mobo combo broken?
Message-ID: <20010808181406.A9258@saturn.tlug.org>
Mail-Followup-To: Mike Frisch <mfrisch@saturn.tlug.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <419E5D46960FD211A2D5006008CAC79902E5C425@pcmailsrv1.sac.unify.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <419E5D46960FD211A2D5006008CAC79902E5C425@pcmailsrv1.sac.unify.com>; from mmt@unify.com on Wed, Aug 08, 2001 at 02:35:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2001 at 02:35:07PM -0700, Manuel A. McLure wrote:
> Let me add my voice to the crowd. I have the same MSI K7T Turbo with an
> Athlon TBird 900MHz and 256M of PC133 SDRAM, and kernel 2.4.6 runs
> rock-stable on it. However, 2.4.7 hangs hard after a day or so of uptime -
> no response to pings, can't switch from X to a virtual console, etc. Sysrq-B
> will reboot, but other Sysrq-keys (like Sysrq-S or Sysrq-U) don't seem to
> work. Unfortunately I am invariably in X when this happens so I don't get to
> see ant OOPS text, and there is no OOPS information in the system log after
> the reboot.

I do not know if this is related since it seems to be VIA-based boards
being mentioned here, but I am also experiencing hard lockups on
Athlon-optimized 2.4.7 (and 2.4.7-ac?).  My board is an ASUS A7A266 (ALi
MaGik chipset), Micro PC2100 DDR RAM, and an Athlon T-Bird 1.2GHz.
