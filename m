Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270364AbTGSOuI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 10:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270371AbTGSOuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 10:50:08 -0400
Received: from deepthought.resolution.de ([195.30.142.42]:65455 "EHLO
	deepthought.resolution.de") by vger.kernel.org with ESMTP
	id S270364AbTGSOuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 10:50:03 -0400
Subject: Re: [OT] HURD vs Linux/HURD
From: Christian Reichert <c.reichert@resolution.de>
To: John Bradford <john@grabjohn.com>
Cc: lkml@lrsehosting.com, linux-kernel@vger.kernel.org, lm@bitmover.com,
       rms@gnu.org, Valdis.Kletnieks@vt.edu
In-Reply-To: <200307191503.h6JF3tac002376@81-2-122-30.bradfords.org.uk>
References: <200307191503.h6JF3tac002376@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 19 Jul 2003 17:02:41 +0200
Message-Id: <1058626962.30424.6.camel@stargate>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-19 at 17:03, John Bradford wrote:

> > Given that large chunks of HURD come from Linux, please refer to it as
> > Linux/HURD.
> 
> What HURD code comes from Linux?  GNU/Mach uses code from Linux, but
> not HURD as far as I know.

Neither to my knowledge -

GNU/HURD uses GNU/MACH as the microkernel (and GNU/MACH uses Linux 2.0
drivers), but they are actually thinking of switching to another MACH
implementation once it's stable.

Cheers,
    Chris


