Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUDJEyv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 00:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUDJEyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 00:54:51 -0400
Received: from www.gawab.com ([204.97.230.36]:35081 "HELO gawab.com")
	by vger.kernel.org with SMTP id S261904AbUDJEyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 00:54:50 -0400
Subject: Error while rebooting or shutdown
From: MNH <tuxracer@gawab.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1081572891.3049.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 10 Apr 2004 10:24:51 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

I am using kernel 2.6.0 with kde 3.2. Every once in a while, the system
fails to reboot or shutdown properly and i get something like this :

" unmount exited with preemt_count 2

unmounting filesystems (retry): "

and it just stops there. There were more lines before these but I dont
remember them (and there's no way i can reproduce the error, it doesn't
happen everytime i reboot or shutdown)

can someone give me a hint on what's happening here ?

thanks

