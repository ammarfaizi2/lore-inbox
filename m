Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271153AbTGWHmF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 03:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271155AbTGWHmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 03:42:05 -0400
Received: from sinma-gmbh.17.mind.de ([212.21.92.17]:15367 "EHLO gw.enyo.de")
	by vger.kernel.org with ESMTP id S271153AbTGWHmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 03:42:04 -0400
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test1] ACPI slowdown
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Wed, 23 Jul 2003 09:57:08 +0200
Message-ID: <878yqpptez.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I enable ACPI on my box (Athlon XP at 1.6 GHz, Epox EP-8KHa+
mainboard), it becomes very slow (so slow that it's unusable).

Is this a known issue?  Maybe the thermal limits are misconfigured,
and the CPU clock is throttled unnecessarily (if something like this
is supported at all).
