Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTKQW21 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 17:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbTKQW20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 17:28:26 -0500
Received: from smtp03.web.de ([217.72.192.158]:6939 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261754AbTKQW20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 17:28:26 -0500
From: dodger <shoxx@web.de>
Reply-To: shoxx@web.de
To: linux-kernel@vger.kernel.org
Subject: problem with suspend to disk on linux2.6-t9
Date: Mon, 17 Nov 2003 23:27:24 +0100
User-Agent: KMail/1.5.4
Organization: none.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311172327.24418.shoxx@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi
i am using linux2.6-t9 and i am trying to use suspend to disk
when doing a
< echo -n "disk" > /sys/power/state >

it is suspending real fine.
but it is not resuming at all.
i tried to boot up normally and with resume=/dev/hdb5 ( swap partition ) but 
nothing happens...

it just boots up normally...
i have set /dev/hdb5 as DEFAULT RESUME PARTITION during kernel config...

any ideas?
thanks

