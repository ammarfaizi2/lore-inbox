Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUFJMU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUFJMU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 08:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUFJMU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 08:20:59 -0400
Received: from main.gmane.org ([80.91.224.249]:56460 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261162AbUFJMU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 08:20:58 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Lars <terraformers@gmx.net>
Subject: 2.6.7-rc3: nforce2, no C1 disconnect fixup applied
Date: Thu, 10 Jun 2004 14:18:59 +0200
Message-ID: <ca9jj9$dr$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9e7deef.dip.t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello

problem with 2.6.7-rc3 and asus a7n8x nforce2 board is here that
the C1 disconnect fix is not applied anymore after booting.
-rc2 worked OK without any lockups.
i understand that the new fix in -rc3 checks an bios option
to enable the fixup but the a7n8x bios does not have such option.
so it would be nice to have the possibility to force the fixup, because
it worked really fine here before.

thanks,
lars



