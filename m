Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265175AbUD3SFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbUD3SFi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 14:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbUD3SFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 14:05:37 -0400
Received: from [64.255.133.6] ([64.255.133.6]:28932 "EHLO www2.agilweb.net")
	by vger.kernel.org with ESMTP id S265175AbUD3SFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 14:05:31 -0400
From: pepo <r4mz3z@yahoo.es>
Organization: r4mz3z
To: linux-kernel@vger.kernel.org
Subject: How do I start KDM (KDE)
Date: Thu, 29 Apr 2004 14:22:17 -0500
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404291422.17791.r4mz3z@yahoo.es>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi friends...

  I've compiled recently kde 3.2.1. and works fine... but How do I start my 
"log in" with KDM? because only XDM runs.  I've modified my /etc/inittab 
with:
	x:5:respawn:/usr/local/kde/bin/kdm -nodaemon
  And run KDM, but when try to shutdown using the graphical menu, it did not 
work... I have to use "poweroff" or "shutdown -h".

thanks

-- 
  Linux User Registered #232544
        ICQ : 337889406
  GnuPG-key : www.keyserver.net
 -------------------------------
"Software is like sex,
      it's better when it's free."
                  [Linus Torvalds]
