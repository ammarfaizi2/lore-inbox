Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbTIABik (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 21:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbTIABik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 21:38:40 -0400
Received: from PATH.Berkeley.EDU ([128.32.234.234]:4746 "EHLO
	PATH.Berkeley.EDU") by vger.kernel.org with ESMTP id S261367AbTIABij
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 21:38:39 -0400
From: Daniel Lyddy <sprocket@PATH.Berkeley.EDU>
Organization: California CCIT
To: mec@shout.net
Subject: Q> scripts/Menuconfig: line 832: MCmenu78: command not found
Date: Sun, 31 Aug 2003 18:38:25 -0700
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308311838.25279.sprocket@path.berkeley.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this error while trying to use menuconfig to set up Kernel 2.4.22-3mdk 
sources for compilation.  I was trying to enter the "alsa" part of the 
"sound" section.

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: line 832: MCmenu78: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1

Dan

