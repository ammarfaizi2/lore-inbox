Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWFUJud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWFUJud (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 05:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWFUJud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 05:50:33 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:10977 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1751350AbWFUJuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 05:50:32 -0400
Date: Wed, 21 Jun 2006 11:06:23 +0100
From: John Rigg <lk@sound-man.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: 2.6.17-rt1 unknown symbol monotonic_clock
Message-ID: <20060621100623.GA2960@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just compiled 2.6.17-rt1 on x86_64 UP system and got the following
message when doing `make modules_install':
WARNING: /lib/modules/2.6.17-rt1/kernel/drivers/char/hangcheck-timer.ko \
needs unknown symbol monotonic_clock

John
