Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVFEG6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVFEG6i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 02:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVFEG6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 02:58:38 -0400
Received: from linux.dunaweb.hu ([62.77.196.1]:45749 "EHLO linux.dunaweb.hu")
	by vger.kernel.org with ESMTP id S261224AbVFEG6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 02:58:36 -0400
Message-ID: <42A2A657.9060803@freemail.hu>
Date: Sun, 05 Jun 2005 09:14:31 +0200
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: hu-hu, hu, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: USB mice do not work on 2.6.12-rc5-git9, -rc5-mm1, -rc5-mm2
References: <42A2A0B2.7020003@freemail.hu>
In-Reply-To: <42A2A0B2.7020003@freemail.hu>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Boszormenyi írta:
> Hi,
> 
> $SUBJECT says almost all, system is MSI K8TNeo FIS2R,
> Athlon64 3200+, running FC3/x86-64. I use the multiconsole
> extension from linuxconsole.sf.net, the patch does not touch
> anything relevant under drivers/input or drivers/usb.
> 
> The mice are detected just fine but the mouse pointers
> do not move on either of my two screens. The same patch
> (not counting the trivial reject fixes) do work on the
> 2.6.11-1.14_FC3 errata kernel. Both PS2 keyboard on the
> keyboard and aux ports work correctly.

The same patch also works on 2.6.12-rc4-mm2, with working mice.
It seems the bug is mainstream.

Best regards,
Zoltán Böszörményi
