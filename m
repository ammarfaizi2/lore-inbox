Return-Path: <linux-kernel-owner+w=401wt.eu-S1751839AbXAVP6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbXAVP6U (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbXAVP6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:58:20 -0500
Received: from [212.12.190.41] ([212.12.190.41]:32917 "EHLO raad.intranet"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751839AbXAVP6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:58:19 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT question
Date: Mon, 22 Jan 2007 18:59:51 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701221859.51776.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> Linus may be right that perhaps one day the CPU will be so much faster
> than disk that such a copy will not be measurable and then O_DIRECT
> could be downgraded to O_STREAMING or an fadvise. If such a day will
> come by, probably that same day Dr. Tanenbaum will be finally right
> about his OS design too.

Dr. T. is probably right with his OS design, it's just people aren't ready 
for it, yet.


Thanks!

--
Al

