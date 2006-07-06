Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbWGFIwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbWGFIwg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 04:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbWGFIwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 04:52:36 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:46843 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S965065AbWGFIwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 04:52:35 -0400
Date: Thu, 6 Jul 2006 10:52:27 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: AVR32 architecture patch against Linux 2.6.18-rc1 available
Message-ID: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I've put up an updated set of patches for AVR32 support at
http://avr32linux.org/twiki/bin/view/Main/LinuxPatches

The most interesting patch probably is
http://avr32linux.org/twiki/pub/Main/LinuxPatches/avr32-arch-2.patch

which, at 544K, is too large to attach here. Please let me know if you
want me to do it anyway.

Anyone want to have a look at this? I understand that a full review is
a huge job, but I'd appreciate a pointer or two in the general
direction that I need to take this in order to get it acceptable for
mainline.

Håvard
