Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264605AbRFPKMn>; Sat, 16 Jun 2001 06:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264608AbRFPKMd>; Sat, 16 Jun 2001 06:12:33 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:59652 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S264605AbRFPKMS>;
	Sat, 16 Jun 2001 06:12:18 -0400
Date: Fri, 15 Jun 2001 15:14:15 +0000
From: Pavel Machek <pavel@suse.cz>
To: James Simmons <jsimmons@transvirtual.com>
Cc: "David S. Miller" <davem@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: Re: VGA handling was [Re: Going beyond 256 PCI buses]
Message-ID: <20010615151415.A37@toy.ucw.cz>
In-Reply-To: <15145.19442.773217.177804@pizda.ninka.net> <Pine.LNX.4.10.10106141650490.12951-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10106141650490.12951-100000@transvirtual.com>; from jsimmons@transvirtual.com on Thu, Jun 14, 2001 at 04:55:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Yes I know. Also each card needs it own special functions to handle
> programming the CRTC, SEQ registers etc. Perhaps for real multihead
> support I guess the user will have to use fbdev. vgacon can just exist for
> single head systems. I guess it is time to let vga go. It is old technology. 

It is still faster than fbdev, and not all cards have fbdev drivers. This
should work with any vga card, right?
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

