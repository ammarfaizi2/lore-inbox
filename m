Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273996AbRJDVoz>; Thu, 4 Oct 2001 17:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277235AbRJDVoh>; Thu, 4 Oct 2001 17:44:37 -0400
Received: from anime.net ([63.172.78.150]:9737 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S273996AbRJDVoR>;
	Thu, 4 Oct 2001 17:44:17 -0400
Date: Thu, 4 Oct 2001 14:43:24 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <harri@synopsys.COM>, <linux-kernel@vger.kernel.org>
Subject: Re: CPU Temperature?
In-Reply-To: <E15pFns-0004DA-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0110041442430.3919-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2001, Alan Cox wrote:
> > How can I access the CPU temperature, fan speed etc. from Linux?
> > Or is this too hardware dependent to implement a common interface?
> lm-sensors - it works well. Its shipped in some vendor trees

Whats the schedule to merge with mainline kernel? Right now we have two
i2c trees -- the one in the kernel and the one in lm-sensors...

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

