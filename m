Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbTIIR1m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 13:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264318AbTIIR1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 13:27:42 -0400
Received: from mail.velocity.net ([208.3.88.4]:23253 "EHLO mail.velocity.net")
	by vger.kernel.org with ESMTP id S264291AbTIIR1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 13:27:21 -0400
Subject: linux 2.4.X and Rocket 1540 SATA
From: Dale Blount <linux-kernel@dale.us>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1063128440.4956.22.camel@dale.velocity.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 13:27:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to get a HighPoint Rocket SATA (4 port) card working with
kernel 2.4.X.  Currently it hangs just after detecting hdc (IDE cdrom).
If I append hdg=noprobe hdi=noprobe, etc the box boots fine, but the
SATA drives are no where to be found.  I'm currently using 2.4.22-ac1 to
support the onboard intel SATA which works fine. 

I'm not sure what other information you'd need to help me debug this,
but I'm willing to provide whatever is needed.

Thanks,

Dale

