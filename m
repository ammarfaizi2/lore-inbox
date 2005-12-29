Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVL2XHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVL2XHJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 18:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVL2XHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 18:07:09 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:4587 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751111AbVL2XHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 18:07:07 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.6..15-rc7: CONFIG_HOTPLUG help text
Date: Fri, 30 Dec 2005 10:07:12 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <drq8r15vvepe8ike7tkm5mkcfp41npph2h@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

"
CONFIG_HOTPLUG:

This option is provided for the case where no in-kernel-tree
modules require HOTPLUG functionality, but a module built
outside the kernel tree does. Such modules require Y here.
"

This gives no indication it is required for udev.  Or is it me confused?

Thanks,
Grant.
