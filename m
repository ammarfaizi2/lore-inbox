Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316785AbSEUXac>; Tue, 21 May 2002 19:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316784AbSEUXaa>; Tue, 21 May 2002 19:30:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26639 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316785AbSEUX3a>; Tue, 21 May 2002 19:29:30 -0400
Date: Wed, 22 May 2002 00:29:23 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Wayne.Brown@altec.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.17
Message-ID: <20020522002923.A10208@flint.arm.linux.org.uk>
In-Reply-To: <86256BC0.00807DCA.00@smtpnotes.altec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 06:20:56PM -0500, Wayne.Brown@altec.com wrote:
> So, I'm just getting used to the idea of using new tools to build kernels,
> and now I learn that 2.5 breaks an ordinary program that I use all day,
> every day. It just keeps getting better and better...

The 2.<odd> series, like 2.5 is a strictly development kernel series; new
features go into these all the time.  You can expect it to:

1. not build.
2. crash.
3. silently eat your filesystems.
4. break userspace programs.

or any combination of the above.  If you're looking for stability, stick
with the 2.<even> series.
-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

