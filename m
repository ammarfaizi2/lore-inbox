Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270460AbRHQTFg>; Fri, 17 Aug 2001 15:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270495AbRHQTFQ>; Fri, 17 Aug 2001 15:05:16 -0400
Received: from anime.net ([63.172.78.150]:13840 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S270460AbRHQTFF>;
	Fri, 17 Aug 2001 15:05:05 -0400
Date: Fri, 17 Aug 2001 12:05:06 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: <root@chaos.analogic.com>,
        David Christensen <David_Christensen@Phoenix.com>,
        Holger Lubitz <h.lubitz@internet-factory.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Encrypted Swap
In-Reply-To: <m11ymaplzm.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.30.0108171200510.4065-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Aug 2001, Eric W. Biederman wrote:
> Clearing memory on most machines takes a 1s or less.  Think of memory
> fill rates at the 800MB/s level.  Most BIOS's seem to clear some of
> the memory but I haven't read their code to see what they are doing.

Ive measured rates far lower than that, at least for SDRAM.

http://bani.anime.net/memspeed/

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

