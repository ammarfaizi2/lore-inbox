Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264580AbTDPUkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 16:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264581AbTDPUkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 16:40:10 -0400
Received: from h002.c000.snv.cp.net ([209.228.32.66]:59083 "HELO
	c000.snv.cp.net") by vger.kernel.org with SMTP id S264580AbTDPUkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 16:40:08 -0400
X-Sent: 16 Apr 2003 20:52:01 GMT
Message-ID: <006a01c3045a$037f54b0$6901a8c0@athialsinp4oc1>
From: "Brien" <admin@brien.com>
To: "John Bradford" <john@grabjohn.com>
Cc: <linux-kernel@vger.kernel.org>
References: <200304161928.h3GJSopS001481@81-2-122-30.bradfords.org.uk>
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro
Date: Wed, 16 Apr 2003 16:51:53 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK...  Do you get the same locations failing with one pair of DIMMs as
> with another identical pair of DIMMs, or is it just randomly flakey?

never seems to be the same
(maybe a few are, but they've never all been the same--I'd have to look
closely to match any addresses)

> Are you sure it's not the power supply?  If the voltages are only just
> within spec, you could concievably get the behavior you describe.

well, I have a 450 watt power supply that's rated for more than I'm
using--it very rarely even becomes warm after hours of use

the voltages go much higher than they need to; I've also tried adjusting
them and had the same problem

> I wouldn't even bothing trying to run anything on a machine until it
> runs Memtest86 for a couple of hours successfully.

I can with single modules, but not with 2..

I don't know what to do...

thanks for all of the comments/suggestions

----- Original Message -----
From: "John Bradford" <john@grabjohn.com>
To: "Brien" <admin@brien.com>
Cc: "John Bradford" <john@grabjohn.com>; <linux-kernel@vger.kernel.org>
Sent: Wednesday, April 16, 2003 3:28 PM
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro


> > I've now tried running the following configurations
>
> [snip]
>
> > and all of them have the same problem: black screen after kernel loads
> > they all do seem to test with errors when ran with another module, but
they
> > also DO NOT test as errors when they're alone
>
> OK...  Do you get the same locations failing with one pair of DIMMs as
> with another identical pair of DIMMs, or is it just randomly flakey?
>
> > I'm starting to think it's a problem with my motherboard rather than
with
> > the RAM, because I've tried so many different ways and with different
RAM
> > modules.. but I don't know for sure..
>
> Are you sure it's not the power supply?  If the voltages are only just
> within spec, you could concievably get the behavior you describe.
>
> > basically every time I try to run any linux distribution, even if I
> > type (mem=XXXM), it just doesn't work...
>
> I wouldn't even bothing trying to run anything on a machine until it
> runs Memtest86 for a couple of hours successfully.
>
> John.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


