Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbTESMrT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 08:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbTESMrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 08:47:19 -0400
Received: from 213-84-67-167.adsl.xs4all.nl ([213.84.67.167]:39856 "EHLO
	samba-pdc") by vger.kernel.org with ESMTP id S262444AbTESMrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 08:47:18 -0400
Subject: timer interrupts on HP machines
From: Edwin Top <e.top@uzorg.nl>
To: linux-kernel@vger.kernel.org
Organization: Uzorg BV
Message-Id: <1053349215.15402.31.camel@vmware-test.uzorg>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 May 2003 15:00:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw some discussion on this list about HP netserver hardware having
problems with time running forwards & backwards.

Some people tried some MP spec settings in the BIOS and it worked, some
people said it did not work for them.

We are having the same problem here with around 12 (!) servers here
every now and then and are not getting any helpfull support from HP.

Could someone who had the problem (discussed in February 2003 here)
contact me and tell me if they are still experiencing the problem or
tell me how they solved it?

I am suspecting that it is a HP firmware problem, but specifically
triggered by the linux kernel.

Cheers,
-- 
Edwin Top <e.top@uzorg.nl>
Uzorg BV

The person who says it cannot be done should not interrupt the person doing it.
--Chinese Proverb


