Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269239AbRGaKYn>; Tue, 31 Jul 2001 06:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269238AbRGaKYe>; Tue, 31 Jul 2001 06:24:34 -0400
Received: from t2.redhat.com ([199.183.24.243]:34288 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S269237AbRGaKYV>; Tue, 31 Jul 2001 06:24:21 -0400
Message-ID: <3B66875D.E8006890@redhat.com>
Date: Tue, 31 Jul 2001 11:24:29 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-5smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <200107281645.f6SGjA620666@ns.caldera.de> <3B653211.FD28320@namesys.com> <20010730210644.A5488@caldera.de> <3B65C3D4.FF8EB12D@namesys.com> <20010730224930.A18311@caldera.de> <3B65CC07.24E3EF4C@namesys.com> <20010730232956.A20969@caldera.de> <3B65D613.E8A0F4BF@namesys.com> <9k5nn0$54q$1@forge.intermeta.de> <3B66809C.8CF60411@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hans Reiser wrote:
> All the distros I know of except debian like to put kernel
> patches into their distros first.  You would think they would want them in the
> kernel first so that they could know they are stable, but that would give them
> no "advantage".  Sigh.  I suppose there are much worse things they could do.

In the future, please check your facts more thoroughly. Almost all of
the patches in the Red Hat
2.4.2-2 kernel were bugfixes from later upstream kernel releases.
INCLUDING reiserfs corruption fixes.
Caldera, Suse, Conectiva and Mandrake all do the same. Ok so we all
differ slightly in which bugfixes
each distro picks, and which base version we start with. That's a matter
of taste. And fwiw, 
the 2.4.2-2 Red Hat shipped was closer to 2.4.3-acX than the actual
2.4.2, due to the dozens and 
dozens of bugfixes applied from these newer kernels. (and yes we do test
our kernels. hard. That's 
why we can't recommend reiserfs on anything non Little Endian or 64 bit
right now)

Please take your false conspiracy theories to some place where they are
more appropriate.

Greetings,
   Arjan van de Ven
   Red Hat Linux kernel maintainer
