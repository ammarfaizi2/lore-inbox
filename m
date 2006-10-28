Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750698AbWJ1GrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750698AbWJ1GrK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 02:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWJ1GrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 02:47:10 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:1434 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750698AbWJ1GrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 02:47:09 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4542FCD1.9070301@s5r6.in-berlin.de>
Date: Sat, 28 Oct 2006 08:46:41 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, simoneau@ele.uri.edu
Subject: Re: [sparc64] 2.6.18 unaligned accesses in eth1394
References: <20061010132943.GB18539@ele.uri.edu>	<20061010.151751.90998930.davem@davemloft.net>	<452CE492.2080607@s5r6.in-berlin.de> <20061027.171210.41635662.davem@davemloft.net>
In-Reply-To: <20061027.171210.41635662.davem@davemloft.net>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> Here is the current patch I have Will testing.  It should fix
> all the unaligned u64 pointer dereferences.
> 
> Do you guys mind if I push this into my next batch of 2.6.19-rcX
> networking bug fixes, assuming that testing goes alright for
> Will?

Please do so. Thanks | ACK.
-- 
Stefan Richter
-=====-=-==- =-=- ===--
http://arcgraph.de/sr/
