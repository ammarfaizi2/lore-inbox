Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287966AbSAXRgZ>; Thu, 24 Jan 2002 12:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288238AbSAXRgP>; Thu, 24 Jan 2002 12:36:15 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:46864 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287966AbSAXRgC>;
	Thu, 24 Jan 2002 12:36:02 -0500
Date: Thu, 24 Jan 2002 15:35:33 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Wakko Warner <wakko@animx.eu.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16
In-Reply-To: <20020124123558.A19899@animx.eu.org>
Message-ID: <Pine.LNX.4.33L.0201241534210.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Wakko Warner wrote:

> recent 2.4 kernels seem to love eating away at memory.  After 2 weeks of
> uptime, 2.2.19 would normally consume about 120mb of ram and maybe 1mb of
> swap.  With 2.4.16 it's more than doubled.  Swap usage is 128mb, memory
> useage about 230mb.  Nothing is different between what I ran with 2.2 and
> what I run now with 2.4.

There are known issues with memory management in the main 2.4
kernel.

If you have the time, could you please try my -rmap VM or
andrea's -aa kernel ?

(available from http://surriel.com/patches/ and kernel.org
respectively)

kind regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

