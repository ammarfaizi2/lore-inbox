Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbUB0Sfy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUB0Se0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:34:26 -0500
Received: from 64-186-161-006.cyclades.com ([64.186.161.6]:2962 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262913AbUB0Sds
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:33:48 -0500
Date: Fri, 27 Feb 2004 16:30:43 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: John Bradford <john@grabjohn.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Erik van Engelen <Info@vanE.nl>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Errors on 2th ide channel of promise ultra100 tx2
In-Reply-To: <200402271820.i1RIKVLb000744@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.58L.0402271629430.19209@logos.cnet>
References: <403F2178.70806@vanE.nl> <Pine.LNX.4.58L.0402271420250.18958@logos.cnet>
 <200402271820.i1RIKVLb000744@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Feb 2004, John Bradford wrote:

> > > hdh: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> > > hdh: task_no_data_intr: error=0x04 { DriveStatusError }
> > > hdh: 2128896 sectors (1090 MB) w/83KiB Cache, CHS=2112/16/63
> >
> > Haven't got a clue about these "status=0x51" and "error=0x04". Anyone?
>
> Basically, the errors mean what they say - the drive is in an error
> state, (received an unrecognised command), but is ready for further
> operation.

Received an unrecognised command from the kernel? What can cause that?

Thanks!

