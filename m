Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269971AbUJHN1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269971AbUJHN1r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 09:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269957AbUJHN1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 09:27:47 -0400
Received: from iua-mail.upf.es ([193.145.55.10]:37308 "EHLO iua-mail.upf.es")
	by vger.kernel.org with ESMTP id S269971AbUJHNUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 09:20:49 -0400
Date: Fri, 8 Oct 2004 15:20:44 +0200
From: Maarten de Boer <mdeboer@iua.upf.es>
To: linux-kernel@vger.kernel.org
Subject: e100 not working with 2.6.9-rc3-mm3-vp-t3
Message-Id: <20041008152044.2e92ea80.mdeboer@iua.upf.es>
Organization: IUA-MTG
X-Mailer: Sylpheed version 0.9.9-gtk2-20040229 (GTK+ 2.4.9; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MTG-MailScanner: Found to be clean
X-MTG-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-2.599, required 5, autolearn=disabled,
	BAYES_00 -2.60)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

(Please Cc: me on reply - I am not on the list)

I still can not get my e100 (Intel Corp. 82562EZ 10/100 Ethernet
Controller - rev 01) to work with the latest vp-patched kernel.

I initially tried with a debian style kernel, but now I moved to a
custom, minimally-configured, kernel, and  have tried several
configurations (with, without ACPI)

The module loads correctly, I can configure the interface, but no
packages are either transmitted or received.

The e100 works correctly with (debian) kernel 2.6.7. I have not tried
intermediate or partially patched (as in only rc3, only rc3-mm3)
kernels.

Any suggestions? I'd really love to play with the voluntary
preempt patch!

Maarten

