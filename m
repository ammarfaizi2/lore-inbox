Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263155AbTJaJah (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 04:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTJaJah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 04:30:37 -0500
Received: from main.gmane.org ([80.91.224.249]:53721 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263155AbTJaJaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 04:30:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Karol Czachorowski <narel@fantastyka.net>
Subject: [BUG] via82cxxx in 2.6.0-textX
Date: Fri, 31 Oct 2003 10:30:29 +0100
Message-ID: <pan.2003.10.31.09.30.29.205245@fantastyka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have Duron 850 on VIA 82c686b motherboard (ATA 100). Stable kernels
works ok, but in 2.6 series I've got troubles with disk operations.
Whenever I'm copying files it takes 100% of my CPU and load of a system
grows up to 5-10 (especially if it's a big file). Even reading of floppy
disk (or cdrom) gives similar effects.
I don't know which information will be usefull - dmesg, hdparm, lspci and
config of my kernel are here:
http://syjon.fantastyka.net/~narel/2.6

Karol



