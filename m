Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318148AbSG3KrY>; Tue, 30 Jul 2002 06:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318160AbSG3KrY>; Tue, 30 Jul 2002 06:47:24 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:20230 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318148AbSG3KrY>; Tue, 30 Jul 2002 06:47:24 -0400
Date: Tue, 30 Jul 2002 07:50:29 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Benjamin LaHaise <bcrl@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: async-io API registration for 2.5.29
In-Reply-To: <20020730054111.GA1159@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0207300749000.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, Andrea Arcangeli wrote:

> I find the dynamic syscall approch in some vendor kernel out there
> that implements a /proc/libredhat unacceptable since it's not forward
> compatible with 2.5:

How do you know this one will be compatible with 2.5 ?

You yourself had suggestions for improving the interface
and I wouldn't be surprised if at least some of those
would get merged for 2.5 and would end up changing the
interface ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

