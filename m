Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129696AbQKSOgX>; Sun, 19 Nov 2000 09:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129549AbQKSOgN>; Sun, 19 Nov 2000 09:36:13 -0500
Received: from relay2.inwind.it ([212.141.53.73]:6325 "EHLO relay2.inwind.it")
	by vger.kernel.org with ESMTP id <S129696AbQKSOgA>;
	Sun, 19 Nov 2000 09:36:00 -0500
Date: Sun, 19 Nov 2000 15:06:45 +0100
From: Gianluca Anzolin <g.anzolin@inwind.it>
To: linux-kernel@vger.kernel.org
Subject: XMMS not working on 2.4.0-test11-pre7
Message-ID: <20001119150645.A732@fourier.home.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it seems there has been a change in the format of the /proc/cpuinfo file: infact 'flags: ' became 'features: '

This change broke xmms and could broke any other program which relies on /proc/cpuinfo... 

I hope the problem will be solved (in the kernel or in every other program which uses /proc/cpuinfo) soon...

Bye
	Gianluca
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
