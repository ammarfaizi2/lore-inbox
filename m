Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWBMPQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWBMPQM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWBMPQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:16:12 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:17067 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S932133AbWBMPQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:16:11 -0500
Message-ID: <43F0A2BC.1040806@dgreaves.com>
Date: Mon, 13 Feb 2006 15:16:12 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is my SATA/400GB drive dying?
References: <Pine.LNX.4.64.0602130658110.21652@p34> <Pine.LNX.4.64.0602130659420.21772@p34> <dsq0qp$egf$1@sea.gmane.org>
In-Reply-To: <dsq0qp$egf$1@sea.gmane.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I know you are feeling uneasy at best, but I have more or less the same
>problems with two Raptors (WD740GD) on two Asus P5GCD-V Deluxe (ICH6) MBs. I
>had to pull them out of the box to use the boxes, because they were
>constantly freezing...
>
>Report is here:
>http://linux.tar.bz/reports/oopses/char/2.6.15.1-K01_P4_server.3.dmesg
>	(and the dirs above)
>
>So far I got one or two "me too" responses, but that was all. I think the
>last working kernel was 2.6.11, but that is a bit too old to test now and
>then I was not using libata, AFAIR.
>
>Now one of the boxes uses Seagate ST3250823AS (25d uptime) and the other an
>old PATA WDC WD102BB (yes that is only 10GB!).
>
>How reproducible is yours?
>
>We might file to bugzilla? (So far I always had the attention on LKML quick
>enough)
>  
>
Me too... :)

I've written to ide-linux and lkml (subject usually contains SMART
and/or ATA for easy searching.
http://marc.theaimsgroup.com/?l=linux-kernel&m=113769509617034&w=2
http://marc.theaimsgroup.com/?l=linux-ide&m=113828551519727&w=2
http://marc.theaimsgroup.com/?l=linux-ide&m=113829573105369&w=2
http://marc.theaimsgroup.com/?l=linux-ide&m=113933732903205&w=2

No useful responses but I did gather a few email addresses of people who
had *possibly* related problems.
(I'm just waiting for enough people to complain and raise the profile).

NB: It's my wifes machine so I need to pick my times to get access to
experiment ;)

David

-- 

