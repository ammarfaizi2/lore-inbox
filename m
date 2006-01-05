Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751888AbWAESxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbWAESxY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWAESxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:53:23 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:34773 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S1751886AbWAESxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:53:22 -0500
Date: Thu, 5 Jan 2006 19:53:20 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, lnx4us@gmail.com
Subject: Re: bug reports ignored?
Message-ID: <20060105185319.GB10923@vanheusden.com>
References: <38150.145.117.21.143.1136477335.squirrel@145.117.21.143>
	<9a8748490601050852t1e10ea6evd8769f2f4719186c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490601050852t1e10ea6evd8769f2f4719186c@mail.gmail.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Fri Jan  6 19:20:40 CET 2006
X-Message-Flag: Want to extend your PGP web-of-trust? Coordinate a key-signing
	at www.biglumber.com
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Last couple of weeks I sent 2 bug-reports. They seem to be ignored. I was
> > wondering: what is missing in them? Am I sending them to the incorrect
> > address? One I also put into bugzilla (no reactions either).
> Perhaps you could let us know the subjects & dates of those two
> previous mails so they are easier to locate in the archives?

20051219190137.GA13923@vanheusden.com
Mon, 19 Dec 2005 20:01:47 +0100
[2.6.13.3] occasional oops mostly in iget_locked

It seems that those oopses in iget_locked are gone since I ran 2.6.14.4
and currently run 2.6.15.


Other message:
20060103210252.GA2043@vanheusden.com
Tue, 3 Jan 2006 22:03:36 +0100
[2.6.15] reproducable hang

this one still happens. System loses total network connectivity. When I
dial the system (by phone), asterisk (the software pabx) picks up the
phone and plays a sample, then it becomes mute. After that, the system
doesn't respond to anything at all. Even sysreq+t is ignored.
The last message on the console is:
eth1: transmit error tx status register 82

>  - Sometimes bugs are reported with a *demand* that it be fixed *right
> now* or with other abusive language towards developers in the email.
> Such reports are usually ignored or, if responded to, don't get very
> positive replies.

Haha no I did not do that :-)


Folkert van Heusden

-- 
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
