Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbUBORDa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 12:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbUBORDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 12:03:30 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:11767 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265105AbUBORD3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 12:03:29 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Chip Salzenberg <chip@pobox.com>
Subject: Re: Linux 2.6.3-rc3 - IDE DMA errors on Thinkpad A30
Date: Sun, 15 Feb 2004 18:08:42 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <E1AsO6X-0003hW-1u@tytlal> <200402151658.57710.bzolnier@elka.pw.edu.pl> <20040215163438.GC3789@perlsupport.com>
In-Reply-To: <20040215163438.GC3789@perlsupport.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402151808.42611.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 of February 2004 17:34, Chip Salzenberg wrote:
> According to Bartlomiej Zolnierkiewicz:
> > Please send dmesg command output and your config kernel config
> > if you want anybody to look at IDE problems...
>
> OK, I've entered all the info in Bugzilla:
>
>   http://bugzilla.kernel.org/show_bug.cgi?id=2110
>
> I've also included the SMART error dumps ("smartctl -a").  There are
> no media problems, if I'm reading it right; whatever else is broken,
> the IDE DMA errors seem to be unrelated to actual bad sectors.

There is a media error at sector 4682265. :-(

