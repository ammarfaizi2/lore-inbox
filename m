Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265397AbSJRXxA>; Fri, 18 Oct 2002 19:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265401AbSJRXxA>; Fri, 18 Oct 2002 19:53:00 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7067 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265397AbSJRXxA>;
	Fri, 18 Oct 2002 19:53:00 -0400
Subject: lots of disk messags (2.5.43 bkbits )
From: Stephen Hemminger <shemminger@osdl.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Oct 2002 16:59:01 -0700
Message-Id: <1034985541.22032.3.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of these are showing up on the serial console, but machine is
running fine.

end_request: I/O error, dev 16:00, sector 0

This new and didn't happen yesterday (released 2.5.43) only on the
latest checked in stuff. The machine is on 2-way SMP with IDE.



