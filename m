Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283422AbRLDU0u>; Tue, 4 Dec 2001 15:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283389AbRLDUZF>; Tue, 4 Dec 2001 15:25:05 -0500
Received: from anime.net ([63.172.78.150]:33443 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S283393AbRLDUYK>;
	Tue, 4 Dec 2001 15:24:10 -0500
Date: Tue, 4 Dec 2001 12:24:07 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Jordan Breeding <ledzep37@attbi.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: OSS driver cleanups.
In-Reply-To: <3C0D04A5.7090400@attbi.com>
Message-ID: <Pine.LNX.4.30.0112041223190.14579-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2001, Jordan Breeding wrote:
> Once in 2.5.X will the ALSA drivers still be modular only or will they
> be able to be linked statically into the kernel as the current OSS
> drivers are able to be?

IIRC the work already has been done so you can build yourself a giant
oversized monolithic kernel with statically linked ALSA drivers.

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

