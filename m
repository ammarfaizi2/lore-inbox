Return-Path: <linux-kernel-owner+w=401wt.eu-S965175AbXAJXG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbXAJXG7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 18:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbXAJXG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 18:06:59 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:3472 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965175AbXAJXG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 18:06:58 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19: BUG: soft lockup detected on CPU#0!
Date: Wed, 10 Jan 2007 23:07:27 +0000
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701102307.27123.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After a few days uptime on a 2.6.19 kernel, I see this:

http://devzero.co.uk/~alistair/2.6.19-softlockup.jpg

At which point magic sysrq doesn't work and the machine requires a hard 
reboot. Is there anything that can be done to produce a more verbose message 
when such a soft lockup occurs?

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
