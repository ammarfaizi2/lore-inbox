Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbULTVyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbULTVyr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 16:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbULTVyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 16:54:47 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:52881 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261665AbULTVyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 16:54:40 -0500
Subject: USB storage (pendrive) problems
From: Attila BODY <compi@freemail.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 20 Dec 2004 23:54:39 +0200
Message-Id: <1103579679.23963.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have some weird problems with my pendrives recently. I just compile a
2.6.9 to check if the problem is still exists there.

current kernel is 2.6.10-rc3 and the situation is the following:

If I copy more than few megabytes to the drive, the activity LED keeps
flashing forever. sync, umount keeps runing forever, normal reboot is
inpossible (alt+sysreq+b seems to work)

Tested with usb 1.1 and 2.0 pendrives, behaviour is the same.

Any ideas?

P.S: Please cc directly to me, I am not subscribed, thanks.

compi

