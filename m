Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbUKVDZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbUKVDZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 22:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbUKVDZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 22:25:26 -0500
Received: from tantale.fifi.org ([216.27.190.146]:395 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S261903AbUKVDZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 22:25:24 -0500
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: APM suspend/resume ceased to work with 2.4.28
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 21 Nov 2004 19:25:20 -0800
Message-ID: <87zn1amuov.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seen on a Dell Inspiron 3800 with BIOS revision A17.

APM suspend/resume works perfectly with 2.4.27 (or at least, as well
as APM can).

Since I did not see any differences in arch/i386/kernel/apm.c between
.27 and .28, I'm at loss to explain the problem.

Phil.
