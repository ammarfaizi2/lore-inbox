Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278396AbRJWXmI>; Tue, 23 Oct 2001 19:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278391AbRJWXlt>; Tue, 23 Oct 2001 19:41:49 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:27143 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S278389AbRJWXlp>;
	Tue, 23 Oct 2001 19:41:45 -0400
Date: Tue, 23 Oct 2001 21:42:07 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: safemode <safemode@speakeasy.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: time tells all about kernel VM's
In-Reply-To: <20011023030353Z279218-17408+3723@vger.kernel.org>
Message-ID: <Pine.LNX.4.33L.0110232141080.3690-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001, safemode wrote:

> First the kernel created about 600MB of buffer in addition to the
> application specified 128MB of buffer i had it using (e2defrag -p
> 16384).  This brought the system to a crawl.

Now that I think about it, and read the last message you wrote
in the thread ... do you have some vmstat output during this
time ?

Do you know if e2defrag somehow locks buffers into RAM ?

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

