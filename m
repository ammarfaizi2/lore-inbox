Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132176AbQLRRzk>; Mon, 18 Dec 2000 12:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132177AbQLRRza>; Mon, 18 Dec 2000 12:55:30 -0500
Received: from host.stormwire.com ([209.239.61.195]:63495 "EHLO
	host.stormwire.com") by vger.kernel.org with ESMTP
	id <S132176AbQLRRzP>; Mon, 18 Dec 2000 12:55:15 -0500
From: <jgoins@sunmine.com>
To: "Andrew Morton" <andrewm@uow.edu.au>
Cc: <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Problem with 3c59x and 3C905B
Date: Mon, 18 Dec 2000 12:29:23 -0500
Message-ID: <NCBBIGEIEDLIBLJACBEOEEECDGAA.jgoins@sunmine.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <3A3DE163.5AC30492@uow.edu.au>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>
> Working out why your switch isn't talking full-duplex would
> probably make things work too, but it's not a fix.
>

He said he has a 10/100 hub (NG DS104) -- it is a half-duplex only 10/100
hub.

Regards,
JGoins
jgoins@sunmine.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
