Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136058AbRDVMNx>; Sun, 22 Apr 2001 08:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136056AbRDVMNe>; Sun, 22 Apr 2001 08:13:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28177 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S136059AbRDVMMv>;
	Sun, 22 Apr 2001 08:12:51 -0400
Date: Sun, 22 Apr 2001 13:12:34 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Matthew Kirkwood <matthew@hairy.beasts.org>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Request for comment -- a better attribution system
Message-ID: <20010422131234.B20807@flint.arm.linux.org.uk>
In-Reply-To: <20010421194706.A14896@thyrsus.com> <Pine.LNX.4.30.0104221114020.10515-100000@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0104221114020.10515-100000@sphinx.mythic-beasts.com>; from matthew@hairy.beasts.org on Sun, Apr 22, 2001 at 11:22:11AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2001 at 11:22:11AM +0100, Matthew Kirkwood wrote:
> C: CONFIG_SCSI_BLARG
> 
> tag to MAINTAINERS.  If you _really_ insist, add an:
> 
> F: drivers/scsi/blarg.c
> F: drivers/scsi/blarg.h
> 
> too.  It removes the ambiguity inherent in the current system,
> without adding an overengineered solution with no obvious
> advantages.

And what would:

C: CONFIG_ARM

tell you?  Nothing that is not described in the rest of the "ARM PORT"
entry.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

