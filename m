Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266408AbUBLN0V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 08:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266409AbUBLN0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 08:26:21 -0500
Received: from ddc.ilcddc.com ([12.35.229.4]:32779 "EHLO ddcnyntd.ddc-ny.com")
	by vger.kernel.org with ESMTP id S266408AbUBLN0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 08:26:20 -0500
Message-ID: <89760D3F308BD41183B000508BAFAC4104B16F65@DDCNYNTD>
From: RANDAZZO@ddc-web.com
To: linux-kernel@vger.kernel.org
Subject: Semaphore with timeout....
Date: Thu, 12 Feb 2004 08:22:04 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In reference to loadable kernel modules... (drivers)

Is there a semaphore call that will either release with token or a specified
amt of time....

All I see is:
down_interruptable
up

Maybe there is a spinlock function to do this?

Any help.....
 
"This message may contain company proprietary information. If you are not
the intended recipient, any disclosure, copying, distribution or reliance on
the contents of this message is prohibited. If you received this message in
error, please delete and notify me."

