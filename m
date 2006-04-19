Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWDSOyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWDSOyf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 10:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWDSOyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 10:54:35 -0400
Received: from smtp.tele.fi ([192.89.123.25]:26805 "EHLO smtp.tele.fi")
	by vger.kernel.org with ESMTP id S1750819AbWDSOye convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 10:54:34 -0400
Content-class: urn:content-classes:message
Subject: RE: searching exported symbols from modules
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Wed, 19 Apr 2006 17:54:28 +0300
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <963E9E15184E2648A8BBE83CF91F5FAF5154DF@titanium.secgo.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: searching exported symbols from modules
Thread-Index: AcZjvLWkc0b/IIHCQ9qTBxhwGHvCrAAAlEkg
From: "Antti Halonen" <antti.halonen@secgo.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Arjan,

Thanks for your response.

> they still are... but.. very often if you want to do this you have a
> crooked design, you were very vague about what you are really trying
to
> achieve (you only described your solution, not the problem)

The problem is that I cannot seem to have access to the module linked
list. Ie. I want to traverse the linked list who's nodes contain module
structures.

Or

Access to some global symbol table would be helpful as well. Where's
listed the symbol address and name. Same stuff which is found at
/proc/kallsyms.

Br,
Antti
