Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTKWSuM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 13:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbTKWSuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 13:50:11 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13020 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263387AbTKWSuJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 13:50:09 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Chris Cheney <ccheney@cheney.cx>
Subject: Re: bugme #1217: "Use PCI DMA by default when available" does not work
Date: Sun, 23 Nov 2003 19:51:06 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20031122204828.GE1411@cheney.cx> <200311222320.18382.bzolnier@elka.pw.edu.pl> <20031123013555.GF1411@cheney.cx>
In-Reply-To: <20031123013555.GF1411@cheney.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311231951.06633.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 of November 2003 02:35, Chris Cheney wrote:
> On Sat, Nov 22, 2003 at 11:20:18PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > Chris, please post output of 'lspci -vvv -xxx' - it will be very useful.
> > We can see what registers are programmed differently when autodma is off.
> >
> > --bart
>
> Ok, I have attached the lspci output. This is the output for when
> autodma is off and hdparm -c3 -d1 -u1 has been run.

Thanks, I need also output of lspci when autodma is on.

--bart

