Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVCIVZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVCIVZN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVCIVYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 16:24:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:37003 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262451AbVCIUiG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:38:06 -0500
Subject: Re: [PATCH] remove dead cyrix/centaur mtrr init code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <20050309190920.GA4044@pclin040.win.tue.nl>
References: <200503081937.j28Jb4Vd020597@hera.kernel.org>
	 <1110387326.28860.199.camel@localhost.localdomain>
	 <20050309190920.GA4044@pclin040.win.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110400574.3072.233.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Mar 2005 20:36:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-03-09 at 19:09, Andries Brouwer wrote:
> The moment you report that the follow-up patch is fine, we can
> remove the #if 0 and insert the initcalls instead.
> 
> So, all is well today, and we are waiting for your report.

Ok works for me. I'll let you know ASAP.

