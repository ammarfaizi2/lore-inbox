Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315298AbSDWS1N>; Tue, 23 Apr 2002 14:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315294AbSDWSZy>; Tue, 23 Apr 2002 14:25:54 -0400
Received: from unet4-114.univie.ac.at ([131.130.233.114]:4480 "EHLO server.lan")
	by vger.kernel.org with ESMTP id <S315293AbSDWSZt>;
	Tue, 23 Apr 2002 14:25:49 -0400
From: Melchior FRANZ <a8603365@unet.univie.ac.at>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
Date: Tue, 23 Apr 2002 20:23:11 +0200
User-Agent: KMail/1.4.5
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC51494.8040309@evision-ventures.com>
X-PGP: http://www.unet.univie.ac.at/~a8603365/melchior.franz
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200204232023.11524@pflug3.gphy.univie.ac.at>
Content-Type: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Dalecki -- Tuesday 23 April 2002 10:00:
> Looks like the oops came from module code.
> Which modules did you use: ide-flappy and ide-scsi are still
> in need of the same medication ide-cd got.

I've got the same oops, but I have ide-cd compiled into the kernel, and use
neither ide-scsi nor ide-floppy. It's obviously a ide-cd problem.
(Oops report on request.)

m.

