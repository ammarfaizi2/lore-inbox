Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTELQUJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 12:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTELQUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 12:20:08 -0400
Received: from havoc.daloft.com ([64.213.145.173]:32698 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262253AbTELQUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 12:20:08 -0400
Date: Mon, 12 May 2003 12:32:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, willy@debian.org,
       davem@redhat.com
Subject: Message Signalled Interrupt support?
Message-ID: <20030512163249.GF27111@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anybody done any work, or put any thought, into MSI support?

Would things massively break if I set up MSI manually in the driver?

I heard rumblings on lkml that Intel has done some work internally w/
MSI support in Linux, but that doesn't help me much without further
details ;-)

	Jeff



