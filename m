Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274247AbRISXBK>; Wed, 19 Sep 2001 19:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274249AbRISXA7>; Wed, 19 Sep 2001 19:00:59 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:56842 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S274247AbRISXAo>;
	Wed, 19 Sep 2001 19:00:44 -0400
Date: Wed, 19 Sep 2001 20:00:44 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rob Fuller <rfuller@nsisoftware.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <m1iteegag6.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33L.0109192000050.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Sep 2001, Eric W. Biederman wrote:

> That added to the fact that last time someone ran the numbers linux
> was considerably faster than the BSD for mm type operations when not
> swapping.  And this is the common case.

Optimising the VM for not swapping sounds kind of like
optimising your system for doing empty fork()/exec()/exit()
loops ;)

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

