Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbULEXQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbULEXQv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 18:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbULEXOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 18:14:50 -0500
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:52018 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261410AbULEXOd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 18:14:33 -0500
Subject: Re: [ppp][2.6.10-rc3] Don't work pppd.
From: Paul Fulghum <paulkf@microgate.com>
To: Kirill Yushkov <mail@kirya.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000c01c4db10$c640c630$8e2010ac@kirya>
References: <000c01c4db10$c640c630$8e2010ac@kirya>
Content-Type: text/plain
Date: Sun, 05 Dec 2004 17:14:02 -0600
Message-Id: <1102288443.3386.28.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-06 at 00:24 +0300, Kirill Yushkov wrote:
> My VPN server on the base Poptop (pptpd) failed to work after the upgrade of
> the kernel from 2.6.10-rc2-bk1 to 2.6.10-rc3. In kernel 2.6.10-rc2-bk1 and
> earlier versions the kernel pppd worked well.

I see no changes to the ppp drivers,
pty driver, or tty code between these versions.

It would help to recheck your setup and configuration and
then work through the rc2-bk series to identify more
precisely when this broke.
 
--
Paul Fulghum
paulkf@microgate.com

