Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWCFWJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWCFWJD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWCFWJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:09:03 -0500
Received: from main.gmane.org ([80.91.229.2]:36787 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932386AbWCFWJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:09:00 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: [OT] inotify hack for locate
Date: Mon, 06 Mar 2006 22:08:28 +0000
Message-ID: <yw1xzmk39qg3.fsf@agrajag.inprovide.com>
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com> <1141594983.14714.121.camel@mindpipe> <20060305230821.GA20768@kvack.org> <yw1xu0acbhby.fsf@agrajag.inprovide.com> <20060306215332.GA4836@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82.153.166.94
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (linux)
Cancel-Lock: sha1:pcZOr8hyeCxbQH7jocHEiQnPSp8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> On Ne 05-03-06 23:30:09, M?ns Rullg?rd wrote:
>> Benjamin LaHaise <bcrl@kvack.org> writes:
>> 
>> > On Sun, Mar 05, 2006 at 04:43:03PM -0500, Lee Revell wrote:
>> >> updatedb runs at nice 20 on most distros, and with the CFQ scheduler the
>> >> IO priority follows the nice value, so why does it still kill the
>> >> machine?
>> >
>> > Running updatedb on a laptop when you're sitting in an airplane running 
>> > off of batteries is Not Nice to the user.  I know, I've had it happen far 
>> > too many times.
>> 
>> Running updatedb only if AC powered shouldn't be too difficult.
>
> That makes locate useless on some machines. I have sharp zaurus C3000
> here... It is either powered on *or* connected on AC, but very rarely
> connected to ac while turned on. Well, its power plug located at weird
> place and old software version that prevents charging while turned on
> is contributory factor, but...

OK, although that surely must be an exception.  Most laptops run
happily with AC connected, and the current power source is easily
obtained from some file in /proc that I've forgotten the name of.

-- 
Måns Rullgård
mru@inprovide.com

