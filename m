Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWGPDZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWGPDZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 23:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWGPDZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 23:25:59 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:12778 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S964839AbWGPDZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 23:25:58 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: tighten ATA kconfig dependancies
To: Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Sat, 15 Jul 2006 20:38:01 +0200
References: <6yL2J-7rR-1@gated-at.bofh.it> <6yLco-7DB-1@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1G1p1y-0000ZU-Io@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
> On Sat, 2006-07-15 at 01:34 -0400, Dave Jones wrote:

>> A lot of prehistoric junk shows up on x86-64 configs.
> 
> ... but in general it helps compile testing if you're hacking stuff;
> if your hacking IDE on x86-64 you now have to compile 32 bit as well to
> see if you didn't break the compile for these as well
> 
> So please don't do this, just disable them in your config...

If you want to compile test these drivers, just revert the patch or edit
the .config.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
