Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbTANIcS>; Tue, 14 Jan 2003 03:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbTANIbV>; Tue, 14 Jan 2003 03:31:21 -0500
Received: from dp.samba.org ([66.70.73.150]:23442 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261723AbTANIbS>;
	Tue, 14 Jan 2003 03:31:18 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: Corey Minyard <minyard@mvista.com>
Subject: IPMI
Date: Tue, 14 Jan 2003 19:29:48 +1100
Message-Id: <20030114084011.6AB412C466@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From "make oldconfig":

	*
	* IPMI
	*
	IPMI top-level message handler (IPMI_HANDLER) [N/m/y/?] (NEW) ?
	
	This enables the central IPMI message handler, required for IPMI
	to work.  Note that you must have this enabled to do any other IPMI
	things.  See IPMI.txt for more details.
	
	IPMI top-level message handler (IPMI_HANDLER) [N/m/y/?] (NEW) 

Telling me what IPMI is, and why I might need it, would be a good
thing...  Please, Corey, I'm feeling generation-gapped by the
acronyms...

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
