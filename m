Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTIHBtA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 21:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTIHBtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 21:49:00 -0400
Received: from ejc.ecomda.com ([212.18.24.150]:37604 "EHLO ejc.ecomda.com")
	by vger.kernel.org with ESMTP id S261861AbTIHBs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 21:48:59 -0400
Subject: possible GPL violation by Sigma Designs
From: Torgeir Veimo <torgeir@pobox.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1062985742.3771.16.camel@africa.netenviron.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Mon, 08 Sep 2003 02:49:02 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DVD players based on Sigma Designs EM8500 mpeg4 decoder seems to be
running uClinux. See here for some info:
http://www.avsforum.com/avs-vb/showthread.php?s=&threadid=288489

The Sigma Designs EM8500 is apparently a combined mpeg4 decoder and RISC
processor. I'd assume that they would be required to release source code
on request for their kernel, even if the code is executed on the EM8500
directly, as opposed being controller by a kernel driver running on a
separate processor?

The firmware for the Bravo D1 DVD player can be downloaded as an ISO
image from this page; http://www.vinc.com/support_faq.asp

-- 
Torgeir Veimo <torgeir@pobox.com>

