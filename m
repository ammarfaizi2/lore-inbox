Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTFBHdr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 03:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTFBHdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 03:33:47 -0400
Received: from f13.mail.ru ([194.67.57.43]:29195 "EHLO f13.mail.ru")
	by vger.kernel.org with ESMTP id S262000AbTFBHdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 03:33:46 -0400
From: "Andrey Borzenkov" <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: supermount for 2.5 test version available
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Mon, 02 Jun 2003 11:47:10 +0400
Reply-To: "Andrey Borzenkov" <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19Mk2A-000C2r-00.arvidjaar-mail-ru@f13.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Test version of supermount for kernel 2.5.70 is available on
http://supermount-ng.sf.net/

Many things are still missing and mediactl interface needs redesign.
It is possiblly completely broken for disks anyway. Still it appears
to work for CD-ROMs and floppies to the same extent as in 2.4 (i.e.
I can easily change media and FAM even gets notified about it :).
More details are in release notes on sourceforge.

It is likely the patch won't apply to previous versions; at least
there were some incompatibilities between 2.5.69 and 2.5.70 already.

Please report bugs on sourceforge tracker.

cheers

-andrey
