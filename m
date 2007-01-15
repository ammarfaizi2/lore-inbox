Return-Path: <linux-kernel-owner+w=401wt.eu-S1751793AbXAODVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbXAODVx (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 22:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbXAODVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 22:21:52 -0500
Received: from smtp161.iad.emailsrvr.com ([207.97.245.161]:38465 "EHLO
	smtp161.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbXAODVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 22:21:52 -0500
Message-ID: <45AAF3AC.3070600@gentoo.org>
Date: Sun, 14 Jan 2007 22:23:24 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 2.0b1 (X11/20061221)
MIME-Version: 1.0
To: dlstevens@us.ibm.com
CC: davem@davemloft.net, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: 2.6.19.2 regression introduced by "IPV4/IPV6: Fix inet{,6} device
 initialization order."
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch titled "IPV4/IPV6: Fix inet{,6} device initialization order" 
shipped in 2.6.19.2 appears to be the cause of this regression:

https://bugs.gentoo.org/show_bug.cgi?id=161907

Is this a known issue? Should this patch be dropped from -stable?

Thanks,
Daniel
