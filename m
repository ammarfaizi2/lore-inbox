Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbUBZEdH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 23:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbUBZEdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 23:33:07 -0500
Received: from server1.mpc.com.br ([200.246.0.242]:51720 "EHLO
	server1.mpc.com.br") by vger.kernel.org with ESMTP id S262681AbUBZEdD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 23:33:03 -0500
From: glauber@mpcnet.com.br
Date: Thu, 26 Feb 2004 01:33:02 -0300
To: linux-kernel@vger.kernel.org
Subject: help in sysfs
Message-ID: <20040226043302.GB2892@zion.matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if I'm being redundant

I spent a lot of time looking for it, and did 
not find, so I came here for help
Perhaps anyone can help me, or point me to the 
right place to ask

I did not yet fully understand how sysfs works, 
and so, any docs would be welcome

My main problem is: 
I'm trying to use udev, but some devices for
drivers that are compiled in the kernel does
not appear in. I searched for entries 
representing then in /sys, and found no one
Specifically, no pts is found there
in my .config, I have CONFIG_UNIX98_PTYS=y
What can I do in order to solve this problem?

Thanks in advance

glauber

-- 
Fortune:

Every man is as God made him, ay, and often worse.
		-- Miguel de Cervantes
---
Software Livre 
Tecnologia para um mundo melhor
==============================
Glauber de Oliveira Costa
e-mail: glauber@mpcnet.com.br
jabber: glommer@jabber.org
ICQ # : 18419549
Phone: +55 19 32892120
==============================

