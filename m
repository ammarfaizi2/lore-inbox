Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287139AbSALQEZ>; Sat, 12 Jan 2002 11:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287141AbSALQEO>; Sat, 12 Jan 2002 11:04:14 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:46096 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287139AbSALQDz>;
	Sat, 12 Jan 2002 11:03:55 -0500
Date: Sat, 12 Jan 2002 14:03:43 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Writeout in recent kernels/VMs poor compared to last -ac
In-Reply-To: <009e01c19b7c$463457d0$02c8a8c0@kroptech.com>
Message-ID: <Pine.LNX.4.33L.0201121403040.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jan 2002, Adam Kropelin wrote:

> I recently began regularly transferring large (600 MB+) files to my
> Linux-based fileserver and have noticed what I would characterize as
> poor writeout behavior under this load. I've done a bit of comparison
> testing which may help reveal the problem better.

> -ac, on the other hand, is very smooth (still a noticeable
> oscillation, but far more consistent):

Thanks for tracking down this bug.  I'll try to find out what
is causing it and will attempt to fix this problem.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

