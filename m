Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVESUS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVESUS6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 16:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVESUS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 16:18:58 -0400
Received: from mail2.dolby.com ([204.156.147.24]:62468 "EHLO dolby.com")
	by vger.kernel.org with ESMTP id S261241AbVESUSz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 16:18:55 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Subject: RE: Illegal use of reserved word in system.h
Date: Thu, 19 May 2005 13:18:18 -0700
Message-ID: <2692A548B75777458914AC89297DD7DA05EC7246@bronze.dolby.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Illegal use of reserved word in system.h
Thread-Index: AcVcmbrmkoYs0UlqRA2J8fQabMNS5gAFLCcQ
From: "Gilbert, John" <JGG@dolby.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mer, 2005-05-18 at 22:31, Gilbert, John wrote:
> #JG
> Sorry, I was borrowing the term from the g++ error that this created.
> I'm not trying to imply that someone should be arrested. ;^) Also, 
> like a few people have already mentioned, it doesn't effect the kernel

> at all as it's strictly a C program.

#Alan Cox 
And that wants submitting to the GNU compiler people as a bug I guess ;)

MySQL using kernel headers is a bit sad given that the same macros were
put into proper user mode headers and under even more open licenses by
the Mozilla people with Linus permission.

DRI one does seem to be a real bug.

#JG
Would that be the drm.h use of "virtual", or the lack of an standard
interrupt driven vertical sync interface?
If it's the later, I know of hundreds, if not thousands of programs that
would greatly benefit from such a feature. This, coupled with Andrew
Morton's low latency patch and the already available high resolution
timer support, and Linux could quickly become the multi-media king of
operating systems (not to mention gaming).
Thanks.

John Gilbert
jgg@dolby.com

-----------------------------------------
This message (including any attachments) may contain confidential
information intended for a specific individual and purpose.  If you are not
the intended recipient, delete this message.  If you are not the intended
recipient, disclosing, copying, distributing, or taking any action based on
this message is strictly prohibited.

