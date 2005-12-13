Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbVLMANs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVLMANs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 19:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVLMANs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 19:13:48 -0500
Received: from gate.crashing.org ([63.228.1.57]:17123 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932247AbVLMANr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 19:13:47 -0500
Subject: Re: Memory corruption & SCSI in 2.6.15
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Jens Axboe <axboe@suse.de>,
       Brian King <brking@us.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0512121250130.15597@g5.osdl.org>
References: <1134371606.6989.95.camel@gaston>
	 <Pine.LNX.4.64.0512120909460.15597@g5.osdl.org>
	 <1134419609.6989.116.camel@gaston>
	 <Pine.LNX.4.64.0512121250130.15597@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 11:11:18 +1100
Message-Id: <1134432679.6989.145.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to confirm that current -git now boots fine on my test box.

Ben.


