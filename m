Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263364AbUEBXYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbUEBXYe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 19:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbUEBXYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 19:24:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:6814 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263364AbUEBXYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 19:24:33 -0400
Subject: Re: [Bug 2627] New: Cannot compile 2.6.6-rc3 on PPC	PowerMac G4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, karoly.vegh@uta.at
In-Reply-To: <9480000.1083508940@[10.10.2.4]>
References: <9480000.1083508940@[10.10.2.4]>
Content-Type: text/plain
Message-Id: <1083540139.21436.235.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 03 May 2004 09:22:19 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-03 at 00:42, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=2627
> 
>            Summary: Cannot compile 2.6.6-rc3 on PPC PowerMac G4
>     Kernel Version: 2.6.6-rc3
>             Status: NEW
>           Severity: normal
>              Owner: platform_ppc-32@kernel-bugs.osdl.org
>          Submitter: karoly.vegh@uta.at

I'm about to dbl check, but I've been told the signal and prep problems
are already fixed upstream. KGDB is known not to build and I don't care.

Ben.


