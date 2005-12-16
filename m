Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbVLPRT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVLPRT7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 12:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbVLPRT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 12:19:59 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:60800 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932359AbVLPRT6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 12:19:58 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Re: gtkpod and Filesystem
Date: Fri, 16 Dec 2005 11:19:55 -0600
Message-ID: <F265D57E1F28274EA189ED0566D227DE7F2343@PGJEXC01.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: gtkpod and Filesystem
Thread-Index: AcYCZJzfVnA1QZcHQIqeBJ1GK2Sj+gAABlmg
From: "Bonilla, Alejandro" <alejandro.bonilla@hp.com>
To: "Kasper Sandberg" <lkml@metanurb.dk>
Cc: "Gunter Ohrner" <G.Ohrner@post.rwth-aachen.de>,
       <linux-kernel@vger.kernel.org>, <debian-devel@lists.debian.org>
X-OriginalArrivalTime: 16 Dec 2005 17:19:56.0899 (UTC) FILETIME=[EFC07330:01C60264]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


|On Fri, 2005-12-16 at 10:32 -0600, Bonilla, Alejandro wrote:
|> Gunter,
|> 
|> 	Actually. Issue fixed. It is really odd that a dosfsck fixed it.
|i dont see how that is odd.. if the filesystem was somehow corrupted
|dosfsck would have corrected it.

Odd how it got "corrupted" and odd on why it would work on Windows and
not in Linux.

Anyway, it works now. I was more worried on the FS Panic than anything
else.

.Alejandro

|> ;-)
|> 
|> Thanks,
|> 
|> .Alejandro
|> 
|> ||Alejandro Bonilla wrote:
|> ||> I have Debian Sid with 2.6.15-rc5, I wonder if this could be 
|> ||either with a
|> ||> bug in gtkpod or the kernel (FS Panic).
|> ||
|> ||Maybe an FS error on your iPod? Did you try to reformat or 
|dosfsck it?
|> |
|> |I doubt it, I mean, it works well in Windows and while 
|> |playing. It is only giving trouble in Linux.
|> |
|> |I will look deeper into it, I was just wondering if the FS 
|> |Errors where familiar.
|> |
|> |Thanks,
|> |
|> |.Alejandro
|> |
|> ||
|> ||Greetings,
|> ||
|> ||  Gunter
