Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVGRUQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVGRUQZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 16:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVGRUQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 16:16:24 -0400
Received: from MailBox.iNES.RO ([80.86.96.21]:20877 "EHLO mailbox.ines.ro")
	by vger.kernel.org with ESMTP id S261709AbVGRUP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 16:15:29 -0400
Subject: Re: 2.6.13-rc3 from today: No Toshiba ACPI module load?
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200507170256.j6H2ugUo004904@laptop11.inf.utfsm.cl>
References: <200507170256.j6H2ugUo004904@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=utf-8
Organization: iNES Group
Date: Mon, 18 Jul 2005 23:00:41 +0300
Message-Id: <1121716841.3705.42.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-7) 
Content-Transfer-Encoding: 8bit
X-BitDefender-Scanner: Clean, Agent: BitDefender Milter 1.6.2 on MailBox.iNES.RO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

În data de Sî, 16-07-2005 la 22:56 -0400, Horst von Brand a scris:
> I'm getting:
> # modprobe toshiba_acpi
> FATAL: Error inserting toshiba_acpi (/lib/modules/2.6.13-rc3/kernel/drivers/acpi/toshiba_acpi.ko): No such device
> 
> This is definitely a Toshiba M30 notebook with this.
> Anything else that might be useful?

Does your toshiba use an Phoenix BIOS ?
If yes, the toshiba_acpi module does not apply.

-- 
Cioby


