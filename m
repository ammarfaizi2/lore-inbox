Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290791AbSARTnZ>; Fri, 18 Jan 2002 14:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290792AbSARTnR>; Fri, 18 Jan 2002 14:43:17 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:3335 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290791AbSARTnC>;
	Fri, 18 Jan 2002 14:43:02 -0500
Date: Fri, 18 Jan 2002 17:42:27 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Anish Srivastava <anishs@vsnl.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: kswapd kills linux box with kernel 2.4.17
In-Reply-To: <001701c1a032$50c82ef0$3c00a8c0@baazee.com>
Message-ID: <Pine.LNX.4.33L.0201181741280.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, Anish Srivastava wrote:

> I am having a box with 8GB RAM and 8 CPU's.

> Can any of you help??

There are two kernel patches which could help you, either
Andrea Arcangeli's VM patch (available from kernel.org)
or my -rmap VM patch (available from surriel.com/patches).

kind regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

