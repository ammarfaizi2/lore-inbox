Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbTJGQTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 12:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbTJGQTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 12:19:37 -0400
Received: from winfree.gag.com ([192.133.104.8]:11136 "EHLO winfree.gag.com")
	by vger.kernel.org with ESMTP id S262364AbTJGQTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 12:19:35 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test6 events/0 runaway
From: Bdale Garbee <bdale@gag.com>
Date: Tue, 07 Oct 2003 10:19:32 -0600
Message-ID: <87k77hc963.fsf@rover.gag.com>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying 2.6.0-test6 on a brand-new HP nc4000 notebook, based on a Pentium-M,
with Debian sid userspace.  Kernel built with a fairly boring/naive config.

After boot things are fine for a while, then without any visible diagnostic 
output, the machine gets very slow.  Running top shows that events/0 is 
consuming the CPU.

Suggests for where to look or what to try?

Bdale
