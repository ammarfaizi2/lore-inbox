Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbUD2B0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUD2B0x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 21:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUD2B0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 21:26:53 -0400
Received: from ns1.skjellin.no ([80.239.42.66]:63189 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S262503AbUD2BZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:25:49 -0400
Message-ID: <40905997.9020107@tomt.net>
Date: Thu, 29 Apr 2004 03:25:43 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [sata] new driver -- AHCI
References: <408C1F41.3060206@pobox.com>
In-Reply-To: <408C1F41.3060206@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> So kudos to the AHCI folks (mainly at Intel), for making a decent, open 
> controller.  I always prefer to work on drivers for decent hardware, 
> whose hardware specification is open and public.

Quick questions:

Is the Intel 6300ESB ("Hence Rapids") AHCI based? So far this looks like 
ICH6 too me, but I may be mistaken.

What about the Marvell 88SX5040 PCI-X SATA Controller?

I seem to have problems tracking it down.

-- 
Cheers,
André Tomt
