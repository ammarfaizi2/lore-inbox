Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbTJTBzc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 21:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbTJTBzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 21:55:31 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:50950 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S261614AbTJTBzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 21:55:31 -0400
Message-ID: <3F9342C0.1000705@superbug.demon.co.uk>
Date: Mon, 20 Oct 2003 03:04:48 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031019 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel <linux-kernel@vger.kernel.org>
Subject: IO-APIC IRQ setting fails: VT8235 - Sth Bridge / VT 400 - Nth Bridge
X-Enigmail-Version: 0.81.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have opserved that the current linux 2.6test8 totally fails to 
correctly set the IO-APIC IRQs.
Even in just PIC mode, it cannot change any IRQs. It just has to stay 
with whatever the bios set.

Can anyone give me a URL for the VT8235/VT400 chipsets datasheet 
specification, so that I could implement correct IO-APIC setting for 
Motherboards based on this.

Cheers
James

