Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270784AbRHNUVY>; Tue, 14 Aug 2001 16:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270795AbRHNUVN>; Tue, 14 Aug 2001 16:21:13 -0400
Received: from anime.net ([63.172.78.150]:29456 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S270784AbRHNUVD>;
	Tue, 14 Aug 2001 16:21:03 -0400
Date: Tue, 14 Aug 2001 13:19:53 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Chris Crowther <chrisc@shad0w.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CDP handler for linux
In-Reply-To: <Pine.LNX.4.33.0108141934130.3283-100000@monolith.shad0w.org.uk>
Message-ID: <Pine.LNX.4.30.0108141318370.30363-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001, Chris Crowther wrote:
> 	1) am I nuts
> 	2) is anyone else interested in this

I cant see real justification to put cdp handler in kernelspace.
IMHO this belongs in userspace eg cdpd

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

