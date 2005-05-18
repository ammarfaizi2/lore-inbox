Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVERAwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVERAwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 20:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVERAwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 20:52:06 -0400
Received: from mail2.dolby.com ([204.156.147.24]:24069 "EHLO dolby.com")
	by vger.kernel.org with ESMTP id S262023AbVERAwD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 20:52:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Subject: Illegal use of reserved word in system.h
Date: Tue, 17 May 2005 17:51:36 -0700
Message-ID: <2692A548B75777458914AC89297DD7DA08B0866D@bronze.dolby.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Illegal use of reserved word in system.h
Thread-Index: AcVbQ76I3OSYiaoBTyCgWwQZ5zH11w==
From: "Gilbert, John" <JGG@dolby.com>
To: <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
The use of "new" as a variable name in the macro "__cmpxchg" breaks
builds of other programs that link to include/asm-i386/system.h
I'd like to request that this be renamed to something else, like mynew
or krnew.
Thanks.
John Gilbert
jgg@dolby.com

-----------------------------------------
This message (including any attachments) may contain confidential
information intended for a specific individual and purpose.  If you are not
the intended recipient, delete this message.  If you are not the intended
recipient, disclosing, copying, distributing, or taking any action based on
this message is strictly prohibited.

