Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268197AbUJPRd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268197AbUJPRd1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 13:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268213AbUJPRd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 13:33:27 -0400
Received: from guru.webcon.ca ([216.194.67.26]:30367 "EHLO guru.webcon.ca")
	by vger.kernel.org with ESMTP id S268197AbUJPRdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 13:33:25 -0400
Date: Sat, 16 Oct 2004 13:33:21 -0400 (EDT)
From: "Ian E. Morgan" <imorgan@webcon.ca>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Reconsider dropping "-final" EXTRAVERSION from 2.6.9 release
Message-ID: <Pine.LNX.4.61.0410161316500.5062@dark.webcon.ca>
Organization: "Webcon, Inc"
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="723005273-642536958-1097948001=:5062"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--723005273-642536958-1097948001=:5062
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

I hope other people with influence will speak up on this matter.

I seems like each new kernel in recent times is introducing new release
methodology (the whole "2.6.8.1" fiasco is still fresh in all our minds). Is
the "-final" EXTRAVERSION really necessary?

Thankfully, 2.6.9-final is still in the testing tree. It is my hopes that it
will actually be released as "2.6.9". That's always been good enough.

Linus says "Let's try the 2.4.x release methodology."  The "2.4.x release
methodology" was to change a "Foo-rcX" to a final "Foo" release with no
changes. I see no evidence that any 2.4 kernel (or _any_ Linux kernel) was
ever released as "Foo-final". It may be OK to _call_ it a "final" version
when referring to it, but adding "-final" to the EXTRAVERSION field is just
aggravating and redundant.

My 2¢.

Regards,
Ian Morgan
--723005273-642536958-1097948001=:5062--
