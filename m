Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbTLMCZP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 21:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbTLMCZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 21:25:15 -0500
Received: from main.gmane.org ([80.91.224.249]:15787 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262859AbTLMCZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 21:25:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Increasing HZ (patch for HZ > 1000)
Date: Sat, 13 Dec 2003 03:25:07 +0100
Message-ID: <yw1xn09xwj24.fsf@kth.se>
References: <1071126929.5149.24.camel@idefix.homelinux.org> <1293500000.1071127099@[10.10.2.4]>
 <20031212220853.GA314@elf.ucw.cz>
 <1071269849.4182.14.camel@idefix.homelinux.org>
 <20031212234028.GA541@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:iOFnCV1BWxZmX4VWOSbwZC5Qs1I=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

>> > Every notebook from thinkpad 560X up has produced some kind of
>> > cpu-load-related-noise. You'd have to throw out quite a lot of
>> > notebooks...
>> 
>> You're right, I'm probably not the only one. It may be worth at least
>> having an option to change HZ to less annoying values. Otherwise there
>> are going to be lots of complaints when people try out 2.6 on their
>> laptops and hear that noise. On mine, I seriously could not stand the
>> noise more than 5 minutes. Not because it was that loud but 1 kHz is
>> really annoying.
>
> Okay, we are probably taking other sounds. I can hear cpu-load-related
> noise on every notebook from thinkpad 560X -- in a quiet room, and on
> some machines its rather hard to notice. You probably have way more
> annoying problem.

My laptop makes a slight noise in the speakers when there are
interrupts.  It's only noticeable with an external amplifier
connected.  There's also some ~1 kHz sound coming from the vicinity of
the CPU, particularly when there is network activity.

-- 
Måns Rullgård
mru@kth.se

