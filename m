Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbTJAXoX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 19:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTJAXoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 19:44:23 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:44928
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S262269AbTJAXoW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 19:44:22 -0400
Message-Id: <200310012344.h91Ni2Kn025150@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: OK, what does this mean: (2.6.0-test6) grubby fatal error: unable to 
 find a suitable template
Date: Wed, 01 Oct 2003 17:44:02 -0600
From: reg@dwf.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fcc: outbox
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii

On doing a 'make' and 'make modules' eerything seems fine.
Still fine after 'make module_install'

But the 'make install' generates the error message:

    grubby fatal error: unable to find a suitable template

THe kernel does appear to have been installed in boot, but 
I havent a clue what this error message is trying to tell me.




-- 
                                        Reg.Clemens
                                        reg@dwf.com


