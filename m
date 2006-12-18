Return-Path: <linux-kernel-owner+w=401wt.eu-S1753708AbWLRKQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbWLRKQZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 05:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753721AbWLRKQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 05:16:25 -0500
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:41427 "EHLO
	aa011msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708AbWLRKQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 05:16:24 -0500
Date: Mon, 18 Dec 2006 11:14:51 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Stefan Seyfried <seife@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: s2disk curiosity  :)
Message-ID: <20061218111451.5ffce963@localhost>
In-Reply-To: <20061218093624.GC960@suse.de>
References: <20061218100612.02d807f7@localhost>
	<20061218093624.GC960@suse.de>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.10.6; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006 10:36:24 +0100
Stefan Seyfried <seife@suse.de> wrote:

> It depends on the BIOS. Many BIOSes have a setting where you can set the
> "power fail mode" to "on", "off" or "as before".

Ok, I've found the BIOS setting: Restore on AC Poer Loss = {Power Off,
Power On, Last State}.

Anyway I found strange that the "state" after s2disk is considered
"ON"  ;)

-- 
	Paolo Ornati
	Linux 2.6.20-rc1-g99f5e971 on x86_64
