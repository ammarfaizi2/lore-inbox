Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbTJJU0B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 16:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbTJJU0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 16:26:01 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:33958 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S262613AbTJJU0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 16:26:00 -0400
Message-ID: <14095.165.89.84.90.1065817559.squirrel@www.genebrew.com>
Date: Fri, 10 Oct 2003 16:25:59 -0400 (EDT)
Subject: nforce2 unknown memory device
From: "Rahul Karnik" <rahul@genebrew.com>
To: gregor.burger@aon.at
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregor,

I also have an NForce 2 based board on which I have successfully used both
1GB of memory and an AGP video card (Radeon 9000). The unknown memory
controllers do not seem to affect anything. Are you sure you have loaded
the AGP modules (both agpgart and nvidia-agp)? As for all the memory not
being detected, some memory is being reserved for kernel use -- how are
you coming up with the numbers you sent?

Thanks,
Rahul
--
Rahul Karnik
rahul@genebrew.com
