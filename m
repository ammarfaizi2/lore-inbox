Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282962AbRLWEHc>; Sat, 22 Dec 2001 23:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283340AbRLWEHM>; Sat, 22 Dec 2001 23:07:12 -0500
Received: from hera.cwi.nl ([192.16.191.8]:5553 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S282962AbRLWEHG>;
	Sat, 22 Dec 2001 23:07:06 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 23 Dec 2001 04:06:50 GMT
Message-Id: <UTC200112230406.EAA67448.aeb@cwi.nl>
To: bcrl@redhat.com, cw@f00f.org
Subject: Re: Configure.help editorial policy
Cc: esr@thyrsus.com, garfield@irving.iisd.sra.com,
        linux-kernel@vger.kernel.org, riel@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise writes:

> GiB is not a useful standard because NOBODY USES IT.

If everybody waits until all others use it, nothing will
ever happen. But in fact usage has been increasing over the
past two years. Also if one restricts attention to the Linux world.

But in fact the main purpose is to emphasize that 1000000 and
1048576 are different numbers and therefore need different
abbreviations. M always means 1000000. Mi always means 1048576.
There are not many contexts where an abbreviation for 1048576
is useful, so no great use is ever expected.
The goal is not to promote the abbreviation Gi.
The goal is to stop the people who believe that k means 1024.


Rik van Riel writes:

> the kB vs KiB mess is so ambiguous and complex

Mistake. k always means 1000. Ki always means 1024.

> In many cases binary and decimal units are mixed,
> leading to something which is impossible to "get right".
> Disk space would be one example of this.

No. All disk manufacturers only use decimal units.

Andries

