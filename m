Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135508AbRDVIkN>; Sun, 22 Apr 2001 04:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135517AbRDVIkE>; Sun, 22 Apr 2001 04:40:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24580 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S135508AbRDVIjw>;
	Sun, 22 Apr 2001 04:39:52 -0400
Date: Sun, 22 Apr 2001 09:39:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Eric S. Raymond" <esr@thyrsus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Request for comment -- a better attribution system
Message-ID: <20010422093938.A20807@flint.arm.linux.org.uk>
In-Reply-To: <20010421114942.A26415@thyrsus.com> <E14r6V4-0004XB-00@the-village.bc.nu> <20010421194706.A14896@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010421194706.A14896@thyrsus.com>; from esr@thyrsus.com on Sat, Apr 21, 2001 at 07:47:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2001 at 07:47:06PM -0400, Eric S. Raymond wrote:
> Alan, if MAINTAINERS scaled perfectly I wouldn't have had to spend three
> months just trying to figure out who was reponsible for each of the
> [Cc]onfig.in files.  And even with that amount of effort mostly failing.

Could that be because there _is no_ maintainer for the config.in files?
Therefore, splitting up the MAINTAINERS file achieves nothing.

However, for the specific times that you've unfortunately come across
the problem, and one of the times it was to do with the ARM config.in
file, I can definitely say that the information _has_ been in the
maintainers file, and it _is_ up to date.  Here, let me give an
example:

ARM PORT
P:      Russell King
M:      linux@arm.linux.org.uk
L:      linux-arm-kernel@lists.arm.linux.org.uk
W:      http://www.arm.linux.org.uk/
S:      Maintained

I don't think that you can say that the MAINTAINERS file has failed in
this case, and cutting it up into little pieces solves precisely
nothing.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

