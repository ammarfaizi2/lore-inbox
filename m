Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbUCJWlc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 17:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbUCJWl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 17:41:26 -0500
Received: from mail.ddc-ny.com ([12.35.229.4]:25609 "EHLO ddcnyntd.ddc-ny.com")
	by vger.kernel.org with ESMTP id S262610AbUCJWlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 17:41:21 -0500
Message-ID: <89760D3F308BD41183B000508BAFAC4104B16FF4@DDCNYNTD>
From: RANDAZZO@ddc-web.com
To: linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: debugging after netif_rx....
Date: Wed, 10 Mar 2004 17:01:53 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm writing my first network driver.

I beleive I created the sk_buff correctly after receiving data, and I called
netif_rx...

Nothing happens.............I passed up an ARP frame........

Is there some debugging messages I can turn on to see what happens after I 
call netif_rx?

Regards,
Mike
 
"This message may contain company proprietary information. If you are not
the intended recipient, any disclosure, copying, distribution or reliance on
the contents of this message is prohibited. If you received this message in
error, please delete and notify me."

