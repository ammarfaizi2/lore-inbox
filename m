Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135709AbRD2Jjw>; Sun, 29 Apr 2001 05:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135708AbRD2Jjc>; Sun, 29 Apr 2001 05:39:32 -0400
Received: from adsl-64-163-64-75.dsl.snfc21.pacbell.net ([64.163.64.75]:1028
	"EHLO konerding.com") by vger.kernel.org with ESMTP
	id <S135707AbRD2JjX>; Sun, 29 Apr 2001 05:39:23 -0400
Message-ID: <3AEBE142.E3CAD85E@konerding.com>
Date: Sun, 29 Apr 2001 02:39:14 -0700
From: David Konerding <dek_ml@konerding.com>
X-Mailer: Mozilla 4.73 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: traceroute breaks with 2.4.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can tell, somewhere between 2.4.2 and 2.4.4, traceroute
stopped working.
I see the problem on RH7.x.  Regular kernel compile with near-defaults
for networking,
no firewalling is enabled.  Rebootiing to a similar config under 2.4.2
works OK.

