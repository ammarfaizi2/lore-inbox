Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965233AbVKPEfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965233AbVKPEfv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 23:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbVKPEfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 23:35:51 -0500
Received: from MailBox.iNES.RO ([80.86.96.21]:48807 "EHLO mailbox.ines.ro")
	by vger.kernel.org with ESMTP id S965233AbVKPEfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 23:35:50 -0500
Subject: Re: [linux-pm] [RFC] userland swsusp
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Jones <davej@redhat.com>, kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <20051115233201.GA10143@elf.ucw.cz>
References: <20051115212942.GA9828@elf.ucw.cz>
	 <20051115222549.GF17023@redhat.com>  <20051115233201.GA10143@elf.ucw.cz>
Content-Type: text/plain; charset=utf-8
Organization: iNES Group
Date: Wed, 16 Nov 2005 06:35:30 +0200
Message-Id: <1132115730.2499.37.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 (2.4.1-4) 
Content-Transfer-Encoding: 8bit
X-BitDefender-Scanner: Clean, Agent: BitDefender Milter 1.6.2 on MailBox.iNES.RO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

În data de Mi, 16-11-2005 la 00:32 +0100, Pavel Machek a scris:
> ...but how do you provide nice, graphical progress bar for swsusp
> without this? People want that, and "esc to abort", compression,
> encryption. Too much to be done in kernel space, IMNSHO.

Pavel, you really should _listen_ when someone else is talking about the
same things in different implementations. suspend2 has this feature
(nice graphical progress bars in userspace) for a long time now and it's
compatible with the fedora kernels.

Why don't you and Nigel (of suspend2) can just work together on this ?
It's a shame that much work is wasted in duplicated effort.

-- 
Cioby


