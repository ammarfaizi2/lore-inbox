Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbTI1Taj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 15:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTI1Taj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 15:30:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22544 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262679AbTI1Tai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 15:30:38 -0400
Date: Sun, 28 Sep 2003 20:30:35 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_I8042
Message-ID: <20030928203035.F1428@flint.arm.linux.org.uk>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030928161059.B1428@flint.arm.linux.org.uk> <Pine.LNX.4.44.0309281136141.15408-100000@home.osdl.org> <20030928194511.C1428@flint.arm.linux.org.uk> <Pine.LNX.4.44.0309282119430.17548-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0309282119430.17548-100000@serv>; from zippel@linux-m68k.org on Sun, Sep 28, 2003 at 09:21:15PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28, 2003 at 09:21:15PM +0200, Roman Zippel wrote:
> What did you try? E.g. "select SERIO_I8042 if !EMBEDDED && X86" works fine 
> here.

My information concerning this aspect of the problem came from jejb -
I should have verified it myself before posting.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
