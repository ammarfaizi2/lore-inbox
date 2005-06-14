Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVFNSSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVFNSSN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 14:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVFNSSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 14:18:13 -0400
Received: from mail.dvmed.net ([216.237.124.58]:2026 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261279AbVFNSRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 14:17:43 -0400
Message-ID: <42AF1F3E.9070704@pobox.com>
Date: Tue, 14 Jun 2005 14:17:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Engelhardt <flo@dotbox.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: AHCI chipset for AMD64
References: <1118750451.42aec6f325fc8@www.domainfactory-webmail.de>	<42AF014A.5000104@pobox.com> <20050614200310.143359bc@discovery.hal.lan>
In-Reply-To: <20050614200310.143359bc@discovery.hal.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Engelhardt wrote:
> Sorry, but i forgot to ask one technical question about AHCI.
> Will every AHCI capable controller be supported, for example
> this chipset:
> http://www.vitalitycomputer.com/msirsamd64so.html


The driver is written to the AHCI specification.

As long as the hardware faithfully follows the specification, yes.

	Jeff


