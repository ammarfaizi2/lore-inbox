Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbTJQJ0X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 05:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263359AbTJQJ0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 05:26:23 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:53215 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263358AbTJQJ0W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 05:26:22 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Tomas Szepe <szepe@pinerecords.com>
Subject: Re: [RFT][PATCH] fix ServerWorks PIO auto-tuning
Date: Fri, 17 Oct 2003 11:30:32 +0200
User-Agent: KMail/1.5.4
Cc: Torben Mathiasen <torben.mathiasen@hp.com>, linux-kernel@vger.kernel.org
References: <200310162344.09021.bzolnier@elka.pw.edu.pl> <20031017073742.GA12489@louise.pinerecords.com>
In-Reply-To: <20031017073742.GA12489@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310171130.32514.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 of October 2003 09:37, Tomas Szepe wrote:
> On Oct-16 2003, Thu, 23:44 +0200
>
> Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> > I wonder if this patch fixes problems (reported back in 2.4.21 days)
> > with CSB5 IDE and Compaq Proliant machines.  Please test it if you can.
>
> Sure.  What kernel series is the patch against?

Patch is against 2.6.0-test7 but also applies to 2.4.22 / 2.4.23-pre.

