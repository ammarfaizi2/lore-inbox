Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290224AbSAOSG5>; Tue, 15 Jan 2002 13:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290225AbSAOSGs>; Tue, 15 Jan 2002 13:06:48 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:34442 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S290224AbSAOSGe>; Tue, 15 Jan 2002 13:06:34 -0500
Date: Tue, 15 Jan 2002 10:06:20 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Doug McNaught <doug@wireboard.com>
cc: Felix von Leitner <felix-dietlibc@fefe.de>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>, Greg KH <greg@kroah.com>,
        <linux-kernel@vger.kernel.org>, <andersen@codepoet.org>
Subject: Re: [RFC] klibc requirements
In-Reply-To: <m3k7ujzj3d.fsf@varsoon.denali.to>
Message-ID: <Pine.LNX.4.40.0201151005430.24005-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jan 2002, Doug McNaught wrote:

>
> > as an example (not for the boot process, but an example of a replacement
> > libc use) I use the firewall toolkit, it has been around for a _loooong_
> > time (in software terms anyway) and has a firly odd licence (free for you
> > to use, source available, cannot sell it) which is not compatable with the
> > GPL. with glibc staticly linked this makes huge binaries, with libc5 they
> > were a lot smaller. I would like to try to use this small libc for these
> > proxies, but if the library is GPL, not LGPL I'm not allowed to.
>
> Hmm, I think you can; you just can't redistribute it.  Can you even
> redistribute fwtk on non-commercial terms?
>
nope, only allowed to get it from nai (and they sure don't make it easy to
find on their website)

David Lang

