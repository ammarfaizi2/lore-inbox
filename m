Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbTJOU1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 16:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbTJOU1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 16:27:12 -0400
Received: from web21307.mail.yahoo.com ([216.136.128.232]:9335 "HELO
	web21307.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264296AbTJOU1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 16:27:10 -0400
Message-ID: <20031015202709.38652.qmail@web21307.mail.yahoo.com>
Date: Wed, 15 Oct 2003 13:27:09 -0700 (PDT)
From: George R Goffe <grgoffe@yahoo.com>
Subject: A problem I'm having with mkinitrd for linux-2.6-test7
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

I have built a linux 2.6-test7 kernel on my redhat 8.0 system and am trying to
use mkinitrd. I am getting this message relating to a module not being found
(see command and error message below).

I'm not sure what to do at this point. The make modules produced no problems
but make modules_install had a bunch of depmod problems. I have been using the
module-init-tools-0.9.15-pre2 tools from Rusty's site.

Any/all help/tips/hints/suggestions would be greatly appreciated.

Regards,

George...

2.4.20-20.8smp root->server3# mkinitrd /boot/initrd-2.6.0-test7.img
2.6.0-test7
No module mptbase found for kernel 2.6.0-test7


=====
=====
    _/_/_/_/ _/_/_/_/ _/_/_/_/ _/_/_/_/ _/_/_/_/ _/_/_/_/ -----
   _/       _/       _/    _/ _/    _/ _/       _/
  _/  _/_/ _/_/_/_/ _/    _/ _/_/_/_/ _/  _/_/ _/_/_/_/ -----
 _/    _/ _/       _/    _/ _/    _/ _/    _/ _/
_/_/_/_/ _/_/_/_/ _/_/_/_/ _/    _/ _/_/_/_/ _/_/_/_/ -----
"It's not what you know that hurts you, It's what you know that ain't so." Wil Rogers

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
