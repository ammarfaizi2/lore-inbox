Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVCMQdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVCMQdw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 11:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVCMQdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 11:33:51 -0500
Received: from coderock.org ([193.77.147.115]:29142 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261348AbVCMQdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 11:33:44 -0500
From: Domen Puncer <domen@coderock.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, emoenke@gwdg.de, linux@rainbow-software.org,
       domen@coderock.org
Message-ID: <20050313163330.171476@nd47.coderock.org>
X-Mailer: Domen's patchbomb
Subject: [patch 0/3] cdrom/cdu31a update
Date: Sun, 13 Mar 2005 17:33:31 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

These cdu31a patches are based on http://lkml.org/lkml/2004/12/18/107
from Ondrej Zary <linux@rainbow-software.org>

Split into three files (see replies):
1 - printk and other trivial cleanups
2 - semaphorifization (hey, i invented a new word)
3 - use wait_event instead of sleep_on in irq handling

Patches have been tested by Ondrej, thanks!


	Domen
