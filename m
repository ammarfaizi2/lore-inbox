Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272472AbRH3VO4>; Thu, 30 Aug 2001 17:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272471AbRH3VOr>; Thu, 30 Aug 2001 17:14:47 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:29197 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S272472AbRH3VOc>; Thu, 30 Aug 2001 17:14:32 -0400
Date: Thu, 30 Aug 2001 18:14:35 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Paul Larson <plars@austin.ibm.com>
Cc: Linus Torvalds <Torvalds@Transmeta.COM>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] /proc/vmload memory_pressure meter
In-Reply-To: <999168467.7844.23.camel@plars.austin.ibm.com>
Message-ID: <Pine.LNX.4.33L.0108301813290.6629-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Aug 2001, Paul Larson wrote:

> This patch adds /proc/vmload that reports the current value of
> memory_pressure. The idea came from an enhancement proposed on the
> linux-mm bugzilla (#3007, but it seems to be down atm).

You can find this value in /proc/meminfo, too.

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

