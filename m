Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261416AbSKBVBA>; Sat, 2 Nov 2002 16:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbSKBVBA>; Sat, 2 Nov 2002 16:01:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64523 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261416AbSKBVA7>; Sat, 2 Nov 2002 16:00:59 -0500
Date: Sat, 2 Nov 2002 21:07:24 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Nero <neroz@iinet.net.au>, Romain Lievin <rlievin@free.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
Message-ID: <20021102210724.B8549@flint.arm.linux.org.uk>
Mail-Followup-To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	Nero <neroz@iinet.net.au>, Romain Lievin <rlievin@free.fr>,
	linux-kernel@vger.kernel.org
References: <20020625222135.GA617@free.fr> <3DC378D0.5080703@iinet.net.au> <20021102203608.GB731@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021102203608.GB731@gallifrey>; from gilbertd@treblig.org on Sat, Nov 02, 2002 at 08:36:08PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 08:36:08PM +0000, Dr. David Alan Gilbert wrote:
> Wouldn't it be more helpful to iron the (few) small glitches out of the
> qt based one than write a new one just because you don't happen to like
> the library?

Maybe, maybe not.  Most, if not all of my boxes here don't have qt, and
they're not going to get qt any time soon.  qt has a long list of
dependencies which gtk doesn't have, which, imho is an overriding factor
for why we should have a gtk implementation.

Not that I used the old xconfig often anyway. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

