Return-Path: <linux-kernel-owner+w=401wt.eu-S964901AbXAHVwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbXAHVwH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbXAHVwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:52:06 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53445
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S964901AbXAHVwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:52:05 -0500
Date: Mon, 08 Jan 2007 13:52:05 -0800 (PST)
Message-Id: <20070108.135205.98420473.davem@davemloft.net>
To: petero2@telia.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, kaber@trash.net
Subject: Re: Linux 2.6.20-rc4
From: David Miller <davem@davemloft.net>
In-Reply-To: <m3tzz1p7l8.fsf@telia.com>
References: <Pine.LNX.4.64.0701071442580.3661@woody.osdl.org>
	<20070107.170056.76564352.davem@davemloft.net>
	<m3tzz1p7l8.fsf@telia.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Osterlund <petero2@telia.com>
Date: 08 Jan 2007 21:49:23 +0100

> The first crash was with gcc 4.1.1, but now I recompiled the kernel
> with "gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-56.fc5)" and I
> can still reproduce the same crash. The backtrace looks the same,

Thanks for performing this test.
