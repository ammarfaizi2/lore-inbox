Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbUBIKQZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 05:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbUBIKQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 05:16:25 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:30336 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264498AbUBIKQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 05:16:23 -0500
Date: Mon, 9 Feb 2004 10:26:01 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402091026.i19AQ15t000678@81-2-122-30.bradfords.org.uk>
To: JG <jg@cms.ac>, linux-kernel@vger.kernel.org
In-Reply-To: <20040209095227.AF4261A9ACF@23.cms.ac>
References: <20040208175346.767881A96E1@23.cms.ac>
 <20040209014722.GA22683@stout.hampshire.edu>
 <20040209095227.AF4261A9ACF@23.cms.ac>
Subject: Re: could someone plz explain those ext3/hard disk errors
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> now...hm, it all started when i upgraded from kernel 2.4.19 to 2.6.0
> in late decemeber, the system worked very fine for a week or so
> (having great response times!) but then all of a sudden the problems
> started. 2 disks died. then my gigabit network card was only able to
> transmit 200kb/s (but this was really a hardware problem, a new card
> is working fine again, well...). a week later the next disks are
> having problems and i have yet to RMA three disks. and now the next
> two disks..., i'm getting insane ;) i can't see any EXT3 error anymore
> *g* the next disks will be reiserfs only to see other error messages
> ;) well, but that doesn't solve the problem of 6 disks within 2
> months...this is so unlikely.

Please read the FAQ, fix your mail application - you are sending long
lines, and don't break the CC list.

As to your problem, look at the LBA sector addresses in the error
message:

280923064991615

is your drive really over 100 EB?  No...

John.
