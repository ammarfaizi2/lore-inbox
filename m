Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUHOQ4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUHOQ4i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 12:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUHOQ4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 12:56:36 -0400
Received: from smtp08.web.de ([217.72.192.226]:65471 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S262071AbUHOQ4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 12:56:35 -0400
Subject: Re: [BKPATCH] ACPI for 2.6
From: Marcus Hartig <m.f.h@web.de>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1092509038.7765.271.camel@dhcppc4>
References: <566B962EB122634D86E6EE29E83DD808182C3286@hdsmsx403.hd.intel.com>
	 <1092509038.7765.271.camel@dhcppc4>
Content-Type: text/plain
Date: Sun, 15 Aug 2004 18:58:11 +0200
Message-Id: <1092589091.3806.10.camel@redtuxi>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.2 (1.5.92.2-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:

> Hmm, this config builds for me with gcc 3.3,
> and neither dsfield.c nor acnamesp.h have changed in months.
> 
> is it possible your source tree has been corrupted?

Yes, my kernel source tree was corrupted... Do not know why.
Now, with 2.6.8.1 and the ACPI patch no problems with my nForce2 board.

Thanks,

Marcus

-- 
www.marcush.de

