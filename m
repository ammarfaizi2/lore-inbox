Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161361AbWJKTbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161361AbWJKTbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161364AbWJKTbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:31:51 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:54502 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161363AbWJKTbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:31:48 -0400
Date: Wed, 11 Oct 2006 21:30:27 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com
Subject: Re: GRIO in Linux XFS?
In-Reply-To: <CAEAF2308EEED149B26C2C164DFB20F4DDE78B@ALPMLVEM06.e2k.ad.ge.com>
Message-ID: <Pine.LNX.4.61.0610112129060.9822@yvahk01.tjqt.qr>
References: <CAEAF2308EEED149B26C2C164DFB20F4DDE78B@ALPMLVEM06.e2k.ad.ge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>what is the status of GRIO support in the Linux port of XFS?

Called realtime volume.
(http://en.wikipedia.org/wiki/XFS section 2.11)

>Also, if the answer is 'non existent', what is the recommended
>alternative?  I've got an application that needs to stream a
>huge amount of data to the harddrive without dropping any and
>without blocking the sender.  We will be pushing the limits
>of our high-end raid striped disks.  This seems the exactly
>the type of thing GRIO was made for, but last I heard it was
>missing from Linux XFS with no plans to add it.  Any change
>in that?  I know I can get almost there with I/O priorities
>and the RT features in 2.6... but its not quite the same
>thing.
> 
>Apologies if this has been beat to death here or elsewhere...
>I've googled the heck out of this and rummaged around in the
>list archives (as much as this fscking corporate firewall will
>let me) with little result.  I'll gladly RTFM if someone can
>point me at the right one.  :-/
>
>Feel free to CC me on replies, as I read the LKML in digest
>format.
>
>Thanks,
>
>Thad Phetteplace
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

	-`J'
-- 
