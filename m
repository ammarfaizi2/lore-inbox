Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030593AbVKDDfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030593AbVKDDfm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 22:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030595AbVKDDfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 22:35:42 -0500
Received: from mail.dvmed.net ([216.237.124.58]:17077 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030593AbVKDDfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 22:35:41 -0500
Message-ID: <436AD70A.9060906@pobox.com>
Date: Thu, 03 Nov 2005 22:35:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Parallel ATA with libata status with the patches I'm working
 on
References: <1131029686.18848.48.camel@localhost.localdomain> <20051103144830.GF28038@flint.arm.linux.org.uk> <1131033483.18848.71.camel@localhost.localdomain> <20051103153017.GH28038@flint.arm.linux.org.uk>
In-Reply-To: <20051103153017.GH28038@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> You mentioned that libata doesn't do SWDMA - does it do MWDMA and PIO?

It even supports polled PIO :)

	Jeff


