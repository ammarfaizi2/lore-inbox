Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266527AbUAWHFi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 02:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbUAWHFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 02:05:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:46298 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266528AbUAWHF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 02:05:28 -0500
Subject: Re: logic error in radeonfb.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040123065410.GF9327@redhat.com>
References: <E1Ajuub-0000xr-00@hardwired> <1074840394.949.200.camel@gaston>
	 <20040123065410.GF9327@redhat.com>
Content-Type: text/plain
Message-Id: <1074841392.973.213.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 23 Jan 2004 18:03:13 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok, If this is going to make your merge more difficult, feel free to ignore it.

The "new" radeonfb is a separate driver, so fixing that alone should be
fine.

Ben.


