Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271955AbRHVIEY>; Wed, 22 Aug 2001 04:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271956AbRHVIER>; Wed, 22 Aug 2001 04:04:17 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28720 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S271955AbRHVIEI>; Wed, 22 Aug 2001 04:04:08 -0400
To: Paul <set@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 [I] just run xdos
In-Reply-To: <Pine.LNX.4.33.0108191600580.10914-100000@boston.corp.fedex.com>
	<m166bjokre.fsf@frodo.biederman.org>
	<20010819214322.D1315@squish.home.loc>
	<m1snenmfe0.fsf@frodo.biederman.org>
	<20010820211410.B218@squish.home.loc>
	<m1g0amlzcm.fsf@frodo.biederman.org>
	<20010821214233.F218@squish.home.loc>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Aug 2001 01:56:59 -0600
In-Reply-To: <20010821214233.F218@squish.home.loc>
Message-ID: <m166bgmss4.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul <set@pobox.com> writes:

> 	Dear Eric;
> 
> 	Oops'd twice on intel pentium 90 box. Same dosemu 1.0.0
> binary and config files, 2.4.8-ac7 kernel. Behaviour was same as
> my k6 box-- I did not decode oops, as that box didnt have a
> serial console, and it didnt seem worth transcribing...
> (was unable to oops it running 2.2.18pre21 on p90 box) Here
> is the tail end of an strace. (the last bit that made it across
> the wire during the telnet session-- I logged with fs mounted
> sync, but the end of the log was garbage)

O.k.  Then there is definentily something going on.  From the log
it didn't look like you were doing anything in dosemu.  Just what were
you doing in dosemu.  Starting dos 6.2 and idling or something else.
A feel for what is going on would help.

Eric
