Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUFGJMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUFGJMq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 05:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUFGJMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 05:12:46 -0400
Received: from spy10.spymac.net ([213.218.8.210]:54435 "EHLO spy10.spymac.net")
	by vger.kernel.org with ESMTP id S264346AbUFGJMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 05:12:44 -0400
Content-Disposition: inline
Content-Transfer-Encoding: binary
Mime-Version: 1.0
From: <ckkashyap@spymac.com>
To: linux-kernel@vger.kernel.org, James Buchanan <buchanan@iinet.net.au>
Subject: Re:Re: Re: building MINIX on LINUX using gcc
Reply-To: ckkashyap@spymac.com
Content-Type: text/plain
X-Mailer: AtMail Corp 3.64 - http://webbasedemail.com/
X-Origin: 203.145.179.173
Message-Id: <20040607091243.1034C4C0CD@spy10.spymac.net>
Date: Mon,  7 Jun 2004 03:12:43 -0600 (MDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suggest using GRUB to chainload instead. You put the Minix bootsector
> and boot program into the Minix partition and GRUB can chainload from
> there. No modification of sources needed for that.
Thanks James...this sounds great!


regards,
Kashyap




---- Msg sent via Spymac Mail - http://www.spymac.com
