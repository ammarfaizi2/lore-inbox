Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbTE2VEp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 17:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTE2VEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 17:04:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1705 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262955AbTE2VDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 17:03:14 -0400
Date: Thu, 29 May 2003 14:15:17 -0700 (PDT)
Message-Id: <20030529.141517.39161797.davem@redhat.com>
To: pavel@suse.cz
Cc: ak@suse.de, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: must-fix list, v5
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030529200618.GE1454@elf.ucw.cz>
References: <p73wuga6rin.fsf@oldwotan.suse.de>
	<20030529.023203.41634240.davem@redhat.com>
	<20030529200618.GE1454@elf.ucw.cz>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pavel Machek <pavel@suse.cz>
   Date: Thu, 29 May 2003 22:06:18 +0200
   
   Davem, does trivial copy_in_user I created have expected semantics?

Yes, but obviously it's not a fast one :-)
