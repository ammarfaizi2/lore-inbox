Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTESR1O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 13:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbTESR1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 13:27:14 -0400
Received: from [212.57.173.241] ([212.57.173.241]:48653 "EHLO zzz.zzz")
	by vger.kernel.org with ESMTP id S262569AbTESR1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 13:27:13 -0400
Date: Mon, 19 May 2003 22:56:56 +0600
From: Denis Zaitsev <zzz@cd-club.ru>
To: linux-kernel@vger.kernel.org
Subject: Impossible to turn BROADCAST mode off on ethernet device?
Message-ID: <20030519225656.A6998@natasha.zzz.zzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.20.  I do:

        ifconfig eth0 -broadcast

And BROADCAST isn't turned off...  The ethernet modules are: eepro100,
tulip, 3c59x.  So, what does it mean?

Thanks in advance.
