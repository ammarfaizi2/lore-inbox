Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272148AbTHSEw5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 00:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272152AbTHSEw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 00:52:57 -0400
Received: from [216.52.22.10] ([216.52.22.10]:34974 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S272148AbTHSEw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 00:52:56 -0400
Message-ID: <E18F4A9ED285D41191FA00B0D0498DB90649D4E5@aimexc06.corp.adaptec.com>
From: "Nayak, Samdeep" <Samdeep_Nayak@adaptec.com>
To: linux-kernel@vger.kernel.org
Subject: Linux SCSI benchmarking tool??
Date: Mon, 18 Aug 2003 21:52:54 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to benchmark a iSCSI driver for performance on a 2.4 kernel. I
have used dd, dt, IOmeter and rawio utilities so far and each seemed to
represent a different picture to me on the same setup (Single target with
few LUNS).  (DD showed good performance on an ext2 mounted file system till
I realized that I was writing to the buffer and not writing on the raw
drive). Since I am trying to catch up with the SCSI world, I am just
wondering if any one else has tried any other utilities that would provide
better results or am I doing something wrong here??
 
-Thanks in advance,

-Regards
Samdeep


