Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750804AbWFEJqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWFEJqz (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 05:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWFEJqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 05:46:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51210 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750804AbWFEJqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 05:46:55 -0400
Date: Mon, 5 Jun 2006 10:46:48 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] typo: buad -> baud
Message-ID: <20060605094648.GA12377@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, trivial@kernel.org
References: <20060413113751.GK2335@quickstop.soohrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413113751.GK2335@quickstop.soohrt.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 01:37:51PM +0200, Horst Schirmeier wrote:
> Replacing mistyped "buad" with "baud" where applicable.
> 
> Signed-off-by: Horst Schirmeier <horst@schirmeier.com>

Thanks - I've only picked this up because it's serial/arm related and
obviously correct (doesn't touch any code.)  I'm not sure why anyone
else hasn't picked it up.

> ---
> 
>  arch/mips/ddb5xxx/ddb5476/dbg_io.c        |    2 +-
>  arch/mips/ddb5xxx/ddb5477/kgdb_io.c       |    2 +-
>  arch/mips/gt64120/ev64120/serialGT.c      |    2 +-
>  arch/mips/gt64120/momenco_ocelot/dbg_io.c |    2 +-
>  arch/mips/ite-boards/generic/dbg_io.c     |    2 +-
>  arch/mips/momentum/jaguar_atx/dbg_io.c    |    2 +-
>  arch/mips/momentum/ocelot_c/dbg_io.c      |    2 +-
>  arch/mips/momentum/ocelot_g/dbg_io.c      |    2 +-
>  include/asm-arm/arch-l7200/serial_l7200.h |    2 +-
>  include/asm-arm/arch-l7200/uncompress.h   |    2 +-
>  10 files changed, 10 insertions(+), 10 deletions(-)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
