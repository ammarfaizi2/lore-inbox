Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbUD2DJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUD2DJE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 23:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbUD2DJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 23:09:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:12740 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263019AbUD2DJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 23:09:01 -0400
Date: Wed, 28 Apr 2004 20:08:01 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: whitehorse@mustika.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: QM_MODULES
Message-Id: <20040428200801.7bbe8757.rddunlap@osdl.org>
In-Reply-To: <S263020AbUD2DDL/20040429030311Z+232@vger.kernel.org>
References: <S263020AbUD2DDL/20040429030311Z+232@vger.kernel.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004 23:03:07 -0400 (EDT) whitehorse@mustika.net wrote:

| dear Sir,
|  I have a problem in compiling kernel 2.6.4 from kernel 2.4.19. I use
|  Debian woody. When I rebooting new kernel, some message occur such:
|  "modprobe: QM_MODULES: function not implemented"
|  and I can't load my modules when boot. I would like to waiting any one who
|  answer this. Please send to this mail. Thanks

You need to upgrade to the new module-init-tools...
and read the 2.6 "update FAQ", from here:

  http://www.kernel.org/pub/linux/kernel/people/davej/misc/post-halloween-2.6.txt

--
~Randy
