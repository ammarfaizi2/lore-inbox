Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280327AbRJaRWM>; Wed, 31 Oct 2001 12:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280326AbRJaRWD>; Wed, 31 Oct 2001 12:22:03 -0500
Received: from bitmover.com ([192.132.92.2]:33993 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S280321AbRJaRVv>;
	Wed, 31 Oct 2001 12:21:51 -0500
Date: Wed, 31 Oct 2001 09:22:28 -0800
From: Larry McVoy <lm@bitmover.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Timur Tabi <ttabi@interactivesi.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Module Licensing?
Message-ID: <20011031092228.J1506@work.bitmover.com>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Timur Tabi <ttabi@interactivesi.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <3BE02C94.4020007@interactivesi.com> <Pine.LNX.4.33L.0110311505160.2963-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33L.0110311505160.2963-100000@imladris.surriel.com>; from riel@conectiva.com.br on Wed, Oct 31, 2001 at 03:10:13PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since your program, which happens to consist of one open
> source part and one proprietary part, is partly a derived
> work from the kernel source (by using kernel header files
> and the inline functions in it) your whole work must be
> distributed under the GPL.

This is obviously incorrect, that would say that

	#include <sys/types.h>

means my app is now GPLed.  Good luck enforcing that.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
