Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291641AbSBNNeu>; Thu, 14 Feb 2002 08:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291642AbSBNNel>; Thu, 14 Feb 2002 08:34:41 -0500
Received: from ns.suse.de ([213.95.15.193]:16902 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291641AbSBNNe0>;
	Thu, 14 Feb 2002 08:34:26 -0500
Mail-Copies-To: never
To: m.knoblauch@teraport.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.5-pre1
In-Reply-To: <3C6BB42A.AADAA82E@TeraPort.de>
From: Andreas Jaeger <aj@suse.de>
Date: Thu, 14 Feb 2002 14:34:24 +0100
In-Reply-To: <3C6BB42A.AADAA82E@TeraPort.de> (Martin Knoblauch's message of
 "Thu, 14 Feb 2002 13:57:14 +0100")
Message-ID: <hok7tgtcf3.fsf@gee.suse.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Knoblauch <Martin.Knoblauch@TeraPort.de> writes:

>> linux-2.5.5-pre1
>> 
>> From: Linus Torvalds (torvalds@transmeta.com)
>> Date: Wed Feb 13 2002 - 17:38:12 EST
>> 
>> 
>> This is a _huge_ patch, mainly because it includes three big pending
>> things: the ALSA merge (which is much smaller in the BK tree than in the
>> patch, because a lot of them are due to renames), merging most of x86_64,
>> and merging some PPC patches.
>> 
>
>  just curious :-)) Is the x86_64 stuff based/tested on real HW,
> simulators or just on the specs.

The x86-64 stuff was developed and extensivly tested - and also
demonstrated at the last show cases like LinuxWorldExpo NY ;-) - using
a software simulator.  You cannot develop such a beast just with the
specs...

For more information about Linux on x86-64, check also
http://www.x86-64.org

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
