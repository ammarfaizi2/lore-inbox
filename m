Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265547AbUAGOJm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 09:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265578AbUAGOJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 09:09:35 -0500
Received: from tartutest.cyber.ee ([193.40.6.70]:33289 "EHLO
	tartutest.cyber.ee") by vger.kernel.org with ESMTP id S265547AbUAGOIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 09:08:25 -0500
From: Meelis Roos <mroos@linux.ee>
To: sundarapandian.durairaj@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
In-Reply-To: <6B09584CC3D2124DB45C3B592414FA8308C8B6@bgsmsx402.gar.corp.intel.com>
User-Agent: tin/1.7.4-20031226 ("Taransay") (UNIX) (Linux/2.4.25-pre4 (i686))
Message-Id: <E1AeEM2-0001c8-Or@rhn.tartu-labor>
Date: Wed, 07 Jan 2004 16:08:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DS> Please review this and send your comments.

DS> +menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA, PCI_EXPRESS)"
DS> +       bool "PCI_EXPRESS (EXPERIMENTAL)" 

Why do you use underscore in textual names? "PCI Express" seems more
natural.

-- 
Meelis Roos (mroos@linux.ee)
