Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264892AbUADCFH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 21:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbUADCFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 21:05:07 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:55220 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264892AbUADCFB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 21:05:01 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: maney@pobox.com
Subject: Re: [PATCH] Re: 2.4.22-rc2 ext2 filesystem corruption
Date: Sun, 4 Jan 2004 03:07:48 +0100
User-Agent: KMail/1.5.4
Cc: Martin Maney <maney@two14.net>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200310311941.31930.bzolnier@elka.pw.edu.pl> <20040104011222.GA1433@furrr.two14.net>
In-Reply-To: <20040104011222.GA1433@furrr.two14.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401040307.48530.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 of January 2004 02:12, Martin Maney wrote:
> Okay, by now I have 2.4.23 installed, and with that version (and booting
> from a drive not connected to the Promise controller, a mirror pair on
> a 3ware controller, in fact) I no longer seem to be able to recreate
> the corruption that was previously so repeatable.  The autotune
> parameter makes no difference: it just works.
>
> If this issue is still of interest (ie, it's just by luck that .23
> works), I can do further testing for a while, but the drive that's on
> the Promise will be getting repurposed sooner or later.

I see nothing in 2.4.23 which can explain this.
Probably if you boot from Promise you will see corruption again.

--bart

