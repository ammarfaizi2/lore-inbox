Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbUAaAst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 19:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUAaAss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 19:48:48 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:12543 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264476AbUAaAsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 19:48:05 -0500
Date: Fri, 30 Jan 2004 19:48:03 -0500
From: Willem Riede <wrlk@riede.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: The survival of ide-scsi in 2.6.x
Message-ID: <20040131004803.GY23308@serve.riede.org>
Reply-To: wrlk@riede.org
References: <1072809890.2839.24.camel@mulgrave> <20040103190857.GY5523@suse.de> <20040128132400.GA23308@serve.riede.org> <200401302356.59401.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200401302356.59401.bzolnier@elka.pw.edu.pl> (from B.Zolnierkiewicz@elka.pw.edu.pl on Fri, Jan 30, 2004 at 17:56:59 -0500)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.01.30 17:56, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi!
> 
> Can you split your patch and drop cosmetic changes?
> 
> I have troubles with reading/understanding it,
> I assume Jens has similar problems ;-).

Of course. I'll do that asap.

> BTW maybe we can move things forward:
> fix ide-scsi.c and carefully remove Onstream support from ide-tape.c?

Fixing ide-scsi is what the posted patch is all about.

I was looking for guidance on what you prefered to do with ide-tape,
so given that you would like to remove Onstream support from it, I
will come with a patch for that next.

Thanks, Willem Riede.
