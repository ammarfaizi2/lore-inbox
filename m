Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285161AbSAZRYj>; Sat, 26 Jan 2002 12:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285666AbSAZRYc>; Sat, 26 Jan 2002 12:24:32 -0500
Received: from arsenal.visi.net ([206.246.194.60]:47773 "EHLO visi.net")
	by vger.kernel.org with ESMTP id <S285161AbSAZRYU>;
	Sat, 26 Jan 2002 12:24:20 -0500
Date: Sat, 26 Jan 2002 12:24:16 -0500
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: question about sparc 64-bit user land
Message-ID: <20020126172416.GO388@blimpo.internal.net>
In-Reply-To: <20020126171545.GB11344@fefe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020126171545.GB11344@fefe.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2002 at 12:16:03PM -0500, linux-kernel-owner@vger.kernel.org wrote:
> My understanding is that there is no 64-bit user land support for
> UltraSPARC, although the kernel runs in 64-bit mode.  Is that correct?
> If yes: why is that (still) so?

No, that is incorrect. Debian currenty has 64bit userland support, and I
believe Rockports does aswell. Someone on the sparclinux claims full
64bit bootstrap (including X), but that isn't really needed since 64bit
is actually slower than 32bit userland.

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/       Ben Collins    --    Debian GNU/Linux    --    WatchGuard.com      \
`          bcollins@debian.org   --   Ben.Collins@watchguard.com           '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
