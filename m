Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbTFPWr5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 18:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTFPWr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 18:47:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:26321 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264444AbTFPWrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 18:47:45 -0400
Date: Mon, 16 Jun 2003 15:57:17 -0700 (PDT)
Message-Id: <20030616.155717.58468888.davem@redhat.com>
To: niv@us.ibm.com
Cc: janiceg@us.ibm.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       stekloff@us.ibm.com, girouard@us.ibm.com, lkessler@us.ibm.com,
       kenistonj@us.ibm.com, jgarzik@pobox.com
Subject: Re: patch for common networking error messages
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3EEE49BA.6070401@us.ibm.com>
References: <3EEE40F1.4030107@us.ibm.com>
	<20030616.151308.55864910.davem@redhat.com>
	<3EEE49BA.6070401@us.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Nivedita Singhvi <niv@us.ibm.com>
   Date: Mon, 16 Jun 2003 15:50:34 -0700

   I do see positives in the feature as a whole though.

Would you design a network protocol this way?  By passing
strings like "open connection please", "sure no problem"
back and forth between server and client?

Of course not.

So why are we even remotely considering the standardization
of _STRINGS_ for event reporting?
