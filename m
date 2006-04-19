Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWDSMof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWDSMof (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 08:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWDSMof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 08:44:35 -0400
Received: from smtp.tele.fi ([192.89.123.25]:7093 "EHLO smtp.tele.fi")
	by vger.kernel.org with ESMTP id S1750767AbWDSMoe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 08:44:34 -0400
Content-class: urn:content-classes:message
Subject: searching exported symbols from modules
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Wed, 19 Apr 2006 15:44:32 +0300
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <963E9E15184E2648A8BBE83CF91F5FAF436197@titanium.secgo.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: searching exported symbols from modules
Thread-Index: AcZjrwH++7qErxWaSeGzXsRrc+xaiA==
From: "Antti Halonen" <antti.halonen@secgo.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Apologies if I posted this question to wrong place.

Here's the thing: when loading my module 'a', I want to search modules
list to check if module 'b' is presents, and if it is, initialize my
function pointers to the functions module b has exported. Or at least
search symbols from module b, whatever. The main question is; how to
locate modules 
by name from my module a?

Is this doable? Can anyone give me pointers? 

Sorry for posting such a stupid question, but I didn't run into
satisfactory when searching the archive & many of the functions which
would have resolved this are apparently not exported anymore.

Any comments are really appreciated!

Thanking in advance,
antti


