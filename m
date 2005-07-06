Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVGFPMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVGFPMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 11:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVGFPMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 11:12:16 -0400
Received: from mail.gmx.de ([213.165.64.20]:63940 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262350AbVGFKa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 06:30:59 -0400
X-Authenticated: #428038
Date: Wed, 6 Jul 2005 12:30:48 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc2
Message-ID: <20050706103048.GA22909@merlin.emma.line.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[resending different route to circumvent bogus SPF restrictions]

On Tue, 05 Jul 2005, Linus Torvalds wrote:

> Ok,
>  -rc3 is pretty small, with the bulk of the diff being some defconfig
> updates, and cleanup of xtensa (notably removal of another copy of zlib).

  CC [M]  sound/pci/bt87x.o
sound/pci/bt87x.c: In function `snd_bt87x_detect_card':
sound/pci/bt87x.c:807: error: `driver' undeclared (first use in this function)
sound/pci/bt87x.c:807: error: (Each undeclared identifier is reported only once
sound/pci/bt87x.c:807: error: for each function it appears in.)
sound/pci/bt87x.c: At top level:
sound/pci/bt87x.c:910: error: `driver' used prior to declaration
make[2]: *** [sound/pci/bt87x.o] Error 1
make[1]: *** [sound/pci] Error 2
make: *** [sound] Error 2

configuration attached.

-- 
Matthias Andree

--fUYQa+Pmc3FrFX/N
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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
C9W+Kx7Gzg/RguYPNWfX9f+YPDtebzAAAA==

--fUYQa+Pmc3FrFX/N--
