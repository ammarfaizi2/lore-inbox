Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266875AbUAXGxG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 01:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266876AbUAXGxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 01:53:06 -0500
Received: from pizda.ninka.net ([216.101.162.242]:59574 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S266875AbUAXGxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 01:53:05 -0500
Date: Fri, 23 Jan 2004 22:41:24 -0800 (PST)
Message-Id: <20040123.224124.71115576.davem@redhat.com>
To: jt@hpl.hp.com, jt@bougret.hpl.hp.com
Cc: linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net,
       jgarzik@pobox.com, lists@mdiehl.de
Subject: Re: New IrDA drivers for 2.6.X
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20040124021828.GA22410@bougret.hpl.hp.com>
References: <20040124021828.GA22410@bougret.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
   Date: Fri, 23 Jan 2004 18:18:28 -0800
   
   	Martin Diehl has finished converting all the old style dongle
   driver to the new API. This was the last major feature parity issue
   with 2.4.X, with this work, 2.6.X should support all the IrDA serial
   dongles that 2.4.X supports. Martin also did a few other cleanups and
   fixed tekram-sir so that it works with real hardware.

All applied.  I'll queue this up.  I'll try to get it in
now but it may be deferred to the next 2.6.x release.
