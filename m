Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270593AbRHIU6E>; Thu, 9 Aug 2001 16:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270592AbRHIU5s>; Thu, 9 Aug 2001 16:57:48 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:26373 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266827AbRHIU51>; Thu, 9 Aug 2001 16:57:27 -0400
Date: Thu, 9 Aug 2001 17:57:10 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bulent Abali <abali@us.ibm.com>,
        "Dirk W. Steinberg" <dws@dirksteinberg.de>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Swapping for diskless nodes
In-Reply-To: <E15UrUl-0007Rn-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0108091756420.1439-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2001, Alan Cox wrote:

> Ultimately its an insoluble problem, neither SunOS, Solaris or
> NetBSD are infallible, they just never fail for any normal
> situation, and thats good enough for me as a solution

Memory reservations, with reservations on a per-socket
basis, can fix the problem.

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

