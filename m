Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274238AbRISWt3>; Wed, 19 Sep 2001 18:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274257AbRISWtT>; Wed, 19 Sep 2001 18:49:19 -0400
Received: from otter.mbay.net ([206.40.79.2]:48653 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S274238AbRISWtP> convert rfc822-to-8bit;
	Wed, 19 Sep 2001 18:49:15 -0400
From: John Alvord <jalvo@mbay.net>
To: Dan Hollis <goemon@anime.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Arjan van de Ven <arjanv@redhat.com>,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
Date: Wed, 19 Sep 2001 15:49:24 -0700
Message-ID: <a68iqtovbjt57qqqv1mkrmdsujhu2k3ebu@4ax.com>
In-Reply-To: <m1adzqg8j6.fsf@frodo.biederman.org> <Pine.LNX.4.30.0109191509480.29421-100000@anime.net>
In-Reply-To: <Pine.LNX.4.30.0109191509480.29421-100000@anime.net>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001 15:13:55 -0700 (PDT), Dan Hollis
<goemon@anime.net> wrote:

>On 19 Sep 2001, Eric W. Biederman wrote:
>> Of course VIA looking at what they have done and what that bit is
>> supposed to be is easiest as they have the schemantics of those
>> chips.  But there is not reason to be limited to just that approach.
>
>Testing it is ok, its rolling the "patch" into production kernels that im
>most concerned about.
>
>What happens if the bit happens to fiddle with motherboard voltages and
>you end up destroying peoples hardware...
>
>Until we have a straight answer what the hell this bit does, its a very
>bad idea to put it into *production kernel*.

Of course the BIOS versions made exactly that change...

john
