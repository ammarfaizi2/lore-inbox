Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269860AbRHIU7E>; Thu, 9 Aug 2001 16:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266827AbRHIU6y>; Thu, 9 Aug 2001 16:58:54 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:33541 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269860AbRHIU6r>; Thu, 9 Aug 2001 16:58:47 -0400
Date: Thu, 9 Aug 2001 17:58:33 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Dirk W. Steinberg" <dws@dirksteinberg.de>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Swapping for diskless nodes
In-Reply-To: <m1snf1tb1q.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33L.0108091758070.1439-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Aug 2001, Eric W. Biederman wrote:

> I don't know about that.  We already can swap over just about
> everything because we can swap over the loopback device.

Last I looked the loopback device could deadlock your
system without you needing to swap over it ;)

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

