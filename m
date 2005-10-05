Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbVJERBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbVJERBf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 13:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbVJERBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 13:01:35 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:32312 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030258AbVJERBe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 13:01:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=prDSvd794hFm3COePBCveT2j2xf5xpWSWIp6a1slSV5EfxPJMMT/LY2/kOnH6utd+N8MpRxSmQ4KaY732lEnMrNDYMN5Cbyy4dwQW7IVkfaTWNYLmo3TZQqaiURukuwRJ65rx2incyk3xx+4FRsnUYVDG0hgxoic5b4mFX8r0lU=
Message-ID: <161717d50510051001r59b13e35x270fccd48fd87fda@mail.gmail.com>
Date: Wed, 5 Oct 2005 13:01:33 -0400
From: Dave Neuer <mr.fred.smoothie@pobox.com>
Reply-To: Dave Neuer <mr.fred.smoothie@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <20051005120727.GV10538@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <mail.linux.kernel/20051003203037.GG8548@lkcl.net>
	 <05Oct4.173802edt.33143@gpu.utcc.utoronto.ca>
	 <20051005120727.GV10538@lkcl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/05, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
>
>  where it all goes a bit pearshaped with that chicken-and-egg vicious
>  cycle is if the bottom drops out of 65nm and 45nm processes, such that
>  _even_ the top uniprocessor mass-market chip manufacturers are forced
>  down a parallel processing line.
>
>  my point is: we're starting to see evidence of that happening
>  (small-scale, 2-cores, 2-hyperthreads, talk of 4-cores, etc.
>  even the X-Box 360 PPC 3x2)
>
>  _therefore_, i invite people who do linux kernel development
>  to think ahead - to take a _lead_ for once instead of waiting
>  for hardware to drop into their laps, at which point it is once
>  again too late, the hardware design decisions will have
>  already been made by someone else, and you will be treated
>  like second class citizens.  again.

With all due respect (and I do believe some is due); your comment
above makes no sense. Operating system designers design software to
operate on existing systems -- often doing as much as possible to
ensure that the design supports lots of different systems. However, _a
neccessary prerequisite_ for that activity is "hardware dropping into
their laps." You warn that "the hardware design decisions will have
already been made by someone else;" but that is the order in which it
_neccessarily_ works! What hardware designer out there spends his day
looking around for as-yet-unused (and hence untested) operating
systems that run on some hypothetical yet-to-be-designed hardware and
say to themselves, "ah, that looks nice -- I think I can design some
hardware that will run that software _really well_?"

Your argument defies logic, and it's that fact -- not your intentions
-- that makes this thread so tiresome.

Dave
