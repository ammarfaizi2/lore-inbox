Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbUCIWNo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 17:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUCIWNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 17:13:43 -0500
Received: from mail.ddc-ny.com ([12.35.229.4]:47378 "EHLO ddcnyntd.ddc-ny.com")
	by vger.kernel.org with ESMTP id S262198AbUCIWNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 17:13:41 -0500
Message-ID: <89760D3F308BD41183B000508BAFAC4104B16FE1@DDCNYNTD>
From: RANDAZZO@ddc-web.com
To: linux-newbie@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: getting sk_buff back after calling netif_rx
Date: Tue, 9 Mar 2004 17:13:07 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I allocate a bunch of sk_buffs and have my hardware put them directly into
the buffer...

after I call netif_rx, is there a callback with the stack is done with it so
I can use it again and give it back to the hardware........
 
"This message may contain company proprietary information. If you are not
the intended recipient, any disclosure, copying, distribution or reliance on
the contents of this message is prohibited. If you received this message in
error, please delete and notify me."

