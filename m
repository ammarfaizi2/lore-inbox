Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266066AbUBCTZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 14:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266109AbUBCTYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 14:24:24 -0500
Received: from mail44-s.fg.online.no ([148.122.161.44]:17824 "EHLO
	mail44-s.fg.online.no") by vger.kernel.org with ESMTP
	id S266120AbUBCTEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 14:04:05 -0500
To: John Bradford <john@grabjohn.com>
Cc: =?iso-8859-1?q?Martin_Povoln=FD?= <xpovolny@aurora.fi.muni.cz>,
       linux-kernel@vger.kernel.org, axboe@suse.de, alan@redhat.com
Subject: Re: 2.6.0, cdrom still showing directories after being erased
References: <20040203131837.GF3967@aurora.fi.muni.cz>
	<Pine.LNX.4.53.0402030839380.31203@chaos> <401FB78A.5010902@zvala.cz>
	<Pine.LNX.4.53.0402031018170.31411@chaos>
	<200402031602.i13G2NFi002400@81-2-122-30.bradfords.org.uk>
	<yw1xsmhsf882.fsf@kth.se>
	<200402031635.i13GZJ9Q002866@81-2-122-30.bradfords.org.uk>
	<20040203174606.GG3967@aurora.fi.muni.cz>
	<200402031853.i13Ir1e0003202@81-2-122-30.bradfords.org.uk>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 03 Feb 2004 20:03:53 +0100
In-Reply-To: <200402031853.i13Ir1e0003202@81-2-122-30.bradfords.org.uk> (John
 Bradford's message of "Tue, 3 Feb 2004 18:53:01 GMT")
Message-ID: <yw1xn080m1d2.fsf@kth.se>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> writes:

> Regardless of specs, I don't know what the majority of devices in the
> real world actually do.  Maybe Jens and Alan, (cc'ed), can help.

Just tested with an ASUS SCB-2408 in my laptop.  It gives read errors
after doing a fast erase, just like it should.

-- 
Måns Rullgård
mru@kth.se
