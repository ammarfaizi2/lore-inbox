Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266564AbUAWPAM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 10:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUAWPAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 10:00:12 -0500
Received: from main.gmane.org ([80.91.224.249]:59275 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266564AbUAWPAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 10:00:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Mike <Mike@kordik.net>
Subject: 2.6.1-mm5, kernel panic "Interrupt not syncing"
Date: Fri, 23 Jan 2004 09:58:40 -0500
Message-ID: <pan.2004.01.23.14.58.39.560168@kordik.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have run 2.6.0-test.* kernels, 2.6.1-mm1 and 4 and they all boot fine.
When I go to 2.6.1-mm5 I get a kernel panic and the boot freezes. The
messages go by so quick I can't tell at what point it is doing this but
the last line is interrupt not syncing. Any ideas? I have gone back to
2.6.1-mm4 so I can boot but I was interested in mm5 because it has ALSA
1.01 and I was hoping that would solve my lockup when I got to a web page
with a lot of flash problem but not being able to boot is even worse. :-)

Any ideas on the problem or advice on how to debug this would be most
appreciated.

Thx

Mike

