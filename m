Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVALUoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVALUoh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVALUlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:41:17 -0500
Received: from mail.inter-page.com ([207.42.84.180]:62735 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S261427AbVALUkB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:40:01 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "'selvakumar nagendran'" <kernelselva@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: pipe_wait illustration needed
Date: Wed, 12 Jan 2005 12:39:53 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAA9waMSLI8nEuLrUTm/Ia48QEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20050112044259.53078.qmail@web60609.mail.yahoo.com>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd start with this book:

http://www.oreilly.com/catalog/linuxdrive2/

It does an execelent job of describing virtually the whole topic.  I use it all the
time.

After that it's just a matter of going to the book store and seeing which books make
the most sense to you.

Rob White,
Casabyte, Inc.

-----Original Message-----
From: selvakumar nagendran [mailto:kernelselva@yahoo.com] 
Sent: Tuesday, January 11, 2005 8:43 PM
To: Robert White
Cc: linux-kernel@vger.kernel.org
Subject: RE: pipe_wait illustration needed

--- Robert White <rwhite@casabyte.com> wrote:

In order to understand the calling of schedule() you
have to think in 
terms of time
and strangers.  In particular time passing irregularly
and other 
programs/events
coming along and changing your state.  There are lots
of good books 
that will do a
better version of explaining all this stuff that I,
but I will give you 
---------
 thank u for ur help. Can u give me the names of some
of those books so that I can get additional
information
from them? 

Regards,
selva



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - now with 250MB free storage. Learn more.
http://info.mail.yahoo.com/mail_250

