Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278701AbRLKPZ7>; Tue, 11 Dec 2001 10:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280426AbRLKPZi>; Tue, 11 Dec 2001 10:25:38 -0500
Received: from dsl-213-023-043-244.arcor-ip.net ([213.23.43.244]:1803 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S280191AbRLKPZ1>;
	Tue, 11 Dec 2001 10:25:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
Date: Tue, 11 Dec 2001 16:27:23 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20011211144223.E4801@athlon.random> <Pine.LNX.4.33L.0112111157410.4079-100000@imladris.surriel.com> <20011211152356.I4801@athlon.random>
In-Reply-To: <20011211152356.I4801@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16DooZ-0001J4-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 11, 2001 03:23 pm, Andrea Arcangeli wrote:
> As said I wrote some documentation on the VM for my last speech at the
> one of the most important italian linux events, it explains the basic
> design. It should be published on their webside as soon as I find the
> time to send them the slides. I can post a link once it will be online.

Why not also post the whole thing as an email, right here?

> It shoud allow non VM-developers to understand the logic behind the VM
> algorithm, but understanding those slides it's far from allowing anyone
> to hack the VM.

It's a start.

> I _totally_ agree with Linus when he said "real world is totally
> dominated by the implementation details".

Linus didn't say anything about not documenting the implementation details, 
nor did he say anything about not documenting in general.

> For developers the real freedom is the code, not the documentation and
> the code is there. And I think it's much easier to understand the
> current code (ok I'm biased, but still I believe for outsiders it's
> simpler).

Judging by the number of complaints, it's not easy enough.  I know that, 
personally, decoding your vm is something that's always on my 'things I could 
do if I didn't have a lot of other things to do' list.  So far, only Linus, 
Marcelo, Andrew and maybe Rik seem to have made the investment.  You'd have a 
lot more helpers by now if you gave just a little higher priority to 
documentation

--
Daniel
