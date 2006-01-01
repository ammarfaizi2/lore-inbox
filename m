Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWAALAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWAALAb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 06:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWAALAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 06:00:31 -0500
Received: from mailgate.tebibyte.org ([83.104.187.130]:6148 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S932159AbWAALAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 06:00:30 -0500
Message-ID: <43B7B64A.7060707@tebibyte.org>
Date: Sun, 01 Jan 2006 11:00:26 +0000
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Guildford, UK)
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Chris Ross <lak1646@tebibyte.org>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] Don't panic on IDE DMA errors
References: <Pine.LNX.4.10.10512310158530.22711-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10512310158530.22711-100000@master.linux-ide.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

Andre Hedrick escreveu:
> What was the panic base on error?

This thread covers the initial discovery and diagnosis of the bug...
http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2005-November/032464.html

Regards,
Chris R.
