Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbUEWJPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUEWJPJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 05:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUEWJPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 05:15:09 -0400
Received: from marvin.harmless.hu ([195.70.51.173]:27879 "EHLO
	marvin.harmless.hu") by vger.kernel.org with ESMTP id S262425AbUEWJPE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 05:15:04 -0400
Date: Sun, 23 May 2004 11:16:17 +0200 (CEST)
From: Gergely Czuczy <phoemix@harmless.hu>
X-X-Sender: phoemix@localhost
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4 VS 2.6 fork VS thread creation time test, test source
 updated
Message-ID: <Pine.LNX.4.60.0405231114210.10947@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HD-Virus-Scanned: by amavisd-new-20030616-p7 at harmless.hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've updated the test code source.

Now it shows the difference between the totals and the successive totals.
Totals includes the calls which returned an error while the successive
totals excludes them.

the code is accessable at:
http://phoemix.harmless.hu/pttest.cc


Bye,

Gergely Czuczy
mailto: phoemix@harmless.hu
PGP: http://phoemix.harmless.hu/phoemix.pgp

"Wish a god, a star, to believe in,
With the realm of king of fantasy..."
