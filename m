Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVBLXuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVBLXuu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 18:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVBLXuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 18:50:50 -0500
Received: from smtpout1.uol.com.br ([200.221.4.192]:49554 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261216AbVBLXup
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 18:50:45 -0500
Date: Sat, 12 Feb 2005 21:50:43 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: Re: irq 10: nobody cared! (was: Re: 2.6.11-rc3-mm1)
Message-ID: <20050212235043.GA4291@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050204103350.241a907a.akpm@osdl.org> <20050205224558.GB3815@ime.usp.br> <20050212222104.GA1965@node1.opengeometry.net> <20050212224715.GA8249@ime.usp.br> <20050212232134.GA2242@node1.opengeometry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050212232134.GA2242@node1.opengeometry.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 12 2005, William Park wrote:
> This looks awefully like 'acpi' is on.  If 'acpi=noirq' does not work,
> then try 'pci=noacpi'.

Hi, Willian.

First of all, thank you very much for both your attention and help.

Unfortunately, I have already tried booting the 2.6.11-rc3-mm2 that I just
compiled and I tried using many boot parameters like "acpi=noirq",
"irqpoll", "pci=noacpi", "acpi=off" and setting the BIOS of my motherboard
to "Plug'n'Play OS = Yes" (instead of "Off", which is my default).

To prevent the matters of loosing track of what is being done, I only
changed one option at a time. I put the dmesg logs of all my attempts at
<http://www.ime.usp.br/~rbrito/ide-problem/>.

Please let me know if I can provide any other useful information.


Thank you very much again for any help, Rogério.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
