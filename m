Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261796AbTC1ALy>; Thu, 27 Mar 2003 19:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbTC1ALy>; Thu, 27 Mar 2003 19:11:54 -0500
Received: from [81.2.110.254] ([81.2.110.254]:7161 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S261796AbTC1ALx>;
	Thu, 27 Mar 2003 19:11:53 -0500
Subject: Re: [PATCH] new IDE PIO handlers 2/4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0303280055380.6453-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0303280055380.6453-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048811030.3952.10.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Mar 2003 00:23:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 23:56, Bartlomiej Zolnierkiewicz wrote:
> # Rewritten PIO handlers, both single and multiple sector sizes.
> #
> # They make use of new bio travelsing code and are supposed to be
> # correct in respect to ATA state machine.

Very nice


