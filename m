Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275050AbTHRUze (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 16:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275057AbTHRUzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 16:55:33 -0400
Received: from aneto.able.es ([212.97.163.22]:62175 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S275050AbTHRUzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 16:55:32 -0400
Date: Mon, 18 Aug 2003 22:55:29 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.x ACPI updates
Message-ID: <20030818205529.GC18599@werewolf.able.es>
References: <20030818190906.GA19067@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030818190906.GA19067@gtf.org>; from jgarzik@pobox.com on Mon, Aug 18, 2003 at 21:09:06 +0200
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.18, Jeff Garzik wrote:
> For those without BK, I have extracted Intel's latest 2.4.x ACPI updates
> into patch form:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.22-rc2-acpi1.patch.bz2

The patch has some strange non-ascii chars there:
- the first hunk changes a don't to a don't (an apostrophe to a non-ascii
  acute accent...)
- A für to a fÃ¼r (I see the current fine on a terminal but not the second)
- Some copyright symbols...

See the 1st, 3rd and 4th hunks in the changes to Configure.help.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-rc2-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
