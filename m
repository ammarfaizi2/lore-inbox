Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273580AbRIQMNF>; Mon, 17 Sep 2001 08:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273579AbRIQMMz>; Mon, 17 Sep 2001 08:12:55 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:20241 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S273580AbRIQMMk>;
	Mon, 17 Sep 2001 08:12:40 -0400
Date: Mon, 17 Sep 2001 09:12:43 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <m1elp6s0kp.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33L.0109170909270.2990-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Sep 2001, Eric W. Biederman wrote:

> There is an alternative approach to have better aging information.

[snip incomplete description of data structure]

What you didn't explain is how your idea is related to
aging.

> > For 2.5 I'm making a VM subsystem with reverse mappings, the
> > first iterations are giving very sweet performance so I will
> > continue with this project regardless of what other kernel
> > hackers might say ;)
>
> Do you have any arguments for the reverse mappings or just for some of
> the other side effects that go along with them?

Mainly for the side effects, but until somebody comes
up with another idea to achieve all the side effects I'm
not giving up on reverse mappings. If you can achieve
all the good stuff in another way, show it.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

