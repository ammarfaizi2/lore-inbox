Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265573AbUBKQan (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 11:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265853AbUBKQan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 11:30:43 -0500
Received: from main.gmane.org ([80.91.224.249]:44737 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265573AbUBKQam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 11:30:42 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: reiserfs for bkbits.net?
Date: Wed, 11 Feb 2004 17:30:37 +0100
Message-ID: <yw1xisidino2.fsf@kth.se>
References: <200402111523.i1BFNnOq020225@work.bitmover.com> <20040211161358.GA11564@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:lohf+RPhwDNNwh5EfLkYU8DD6Hg=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander <sander@humilis.net> writes:

> Larry McVoy wrote (ao):
>> We're moving openlogging back to our offices and I'm experimenting
>> with filesystems to see what gives the best performance for BK usage.
>> Reiserfs looks pretty good and I'm wondering if anyone knows any
>> reasons that we shouldn't use it for bkbits.net. Also, would it help
>> if the journal was on a different disk? Most of the bkbits traffic is
>> read so I doubt it.
>> 
>> Please cc me, I'm not on the list.
>
> I've cc'ed the Reiserfs mailinglist.
>
> IME Reiserfs is a fast and stable fs. If you have the time to benchmark
> ext3, reiserfs, jfs and xfs (and ..) with bk then you would know first
> hand which fs is best for you. It might be worth the time.

If someone does any tests, I'd be interested to hear about the
results.

-- 
Måns Rullgård
mru@kth.se

