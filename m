Return-Path: <linux-kernel-owner+w=401wt.eu-S932492AbXAGLos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbXAGLos (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 06:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbXAGLos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 06:44:48 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2194 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932492AbXAGLor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 06:44:47 -0500
Date: Sun, 7 Jan 2007 11:44:39 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc4
Message-ID: <20070107114439.GC21613@flint.arm.linux.org.uk>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 11:56:01AM +0100, Jan Engelhardt wrote:
> On Jan 6 2007 22:19, Linus Torvalds wrote:
> 
> >Leonard NorrgÃ¥rd (1):
> >      sound: hda: detect ALC883 on MSI K9A Platinum motherboards (MS-7280)
> 
> Something seems to have mangled the name, that should have
> been an å not A¥. (Something reencoded it). A gitlog problem?

That is an å if you look at the raw message in UTF-8.  However, Linus
sends mail in with a charset of ISO-8859-1, and if you place UTF-8
encoded text in such a message body, you will see A¥.

Welcome to the mess which the UTF-8 charset creates.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
