Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265689AbUATTta (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 14:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265694AbUATTt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 14:49:28 -0500
Received: from main.gmane.org ([80.91.224.249]:5073 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265689AbUATTqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 14:46:48 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: ALSA vs. OSS
Date: Tue, 20 Jan 2004 20:46:44 +0100
Message-ID: <yw1xzncimmhn.fsf@ford.guide>
References: <1074532714.16759.4.camel@midux> <microsoft-free.87vfn7bzi1.fsf@eicq.dnsalias.org>
 <20040120192401.GA5685@mcgroarty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:ypaWagBc2LzYHJTNaL7EVEAKOnQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian McGroarty <brian@mcgroarty.net> writes:

> On Tue, Jan 20, 2004 at 03:48:54AM +1000, Steve Youngs wrote:
>> * Markus H?stbacka <midian@ihme.org> writes:
>> 
>>   > but ALSA didn't let me to open two sound sources (like XMMS and
>>   > Quake3) at the same time, so I guess it is not really done yet, or
>>   > is it?
>> 
>> Works for me.  Right now I've got 3 instances of mpg123 playing 3
>> different MP3s and XEmacs playing a big .wav file and an audio CD
>> playing.  It's a horrible jumbled mess of noise coming out of my
>> speakers, but it is working.
>
> You probably have a Soundblaster Live or similar, which has multiple
> hardware wave outputs.
>
> OSS has software mixing. ALSA seems designed for people relying on
> esd, aRts or similar multiplexing daemons.

Don't you mean the other way around?

> It's possible to run a program via 'esddsp' or 'artsdsp' to reroute
> /dev/dsp to the daemon, but the overhead isn't so nice, and the output
> quality is often wanting.

True.

-- 
Måns Rullgård
mru@kth.se

