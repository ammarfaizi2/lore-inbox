Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288503AbSADN1b>; Fri, 4 Jan 2002 08:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288521AbSADN1V>; Fri, 4 Jan 2002 08:27:21 -0500
Received: from ns.suse.de ([213.95.15.193]:24582 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288503AbSADN1H>;
	Fri, 4 Jan 2002 08:27:07 -0500
Mail-Copies-To: never
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: Andreas Schwab <schwab@suse.de>, Erik Andersen <andersen@codepoet.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: LSB1.1: /proc/cpuinfo
In-Reply-To: <20020103190219.B27938@thyrsus.com>
	<Pine.GSO.4.21.0201031944320.23693-100000@weyl.math.psu.edu>
	<20020103195207.A31252@thyrsus.com>
	<20020104081802.GC5587@codepoet.org>
	<20020104071940.A10172@thyrsus.com> <je4rm2l0qz.fsf@sykes.suse.de>
	<20020104080358.A11215@thyrsus.com>
From: Andreas Jaeger <aj@suse.de>
Date: Fri, 04 Jan 2002 14:27:01 +0100
In-Reply-To: <20020104080358.A11215@thyrsus.com> ("Eric S. Raymond"'s
 message of "Fri, 4 Jan 2002 08:03:58 -0500")
Message-ID: <u8d70qnt5m.fsf@gromit.moeb>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> writes:

> Andreas Schwab <schwab@suse.de>:
>> |> I'm not very worried about this.  On modern machines int == long 
>> 
>> You mean alpha, ia64, ppc64, s390x, x68-64 are not modern machines?
>
> Well, S390 certainly isn't! :-)

s390x - the zSeries - is newer ;-)

> If the PPC etc. have 32-bit ints then I stand corrected, but I thought the 
> compiler ports on those machines used the native register size same as
> everybody else.

All the ports Andreas mentioned use 32-bit int and 64-bit longs.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
