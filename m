Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTJLMNc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 08:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTJLMNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 08:13:32 -0400
Received: from smtp0.adl1.internode.on.net ([203.16.214.194]:20996 "EHLO
	smtp0.adl1.internode.on.net") by vger.kernel.org with ESMTP
	id S263461AbTJLMNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 08:13:31 -0400
Date: Sun, 12 Oct 2003 21:43:31 +0930
From: "Mark Williams (MWP)" <mwp@internode.on.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Promise Ultra133-TX2 (PCD20269).
Message-ID: <20031012121331.GA665@linux.comp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
Sorry if this post to the list is inapropriate, i havnt been on the
kernel mailing list for long.

I am having rather ugly problems with this card using the PDC20269 chip.
Almost as soon as either of the HDDs on the controller are used, the
kernel hangs solid with a dump of debugging info.

Ive tried moving cards, diff, ram, cpu, etc everything short of changing
MB (never been a problem before installing this card), so im sure that
its this new IDE controller card that is the problem.
I have also tried changing interrupts via the BIOS to remove possible
clashes, but it also has not helped.

I am getting this problem with both the 2.4.22 and the 2.6.0-test7
kernels (tried different minimal configs).

Can anyone help me with this problem?
If any other info is needed, please let me know.

Thanks,
 Mark Williams.
