Return-Path: <linux-kernel-owner+w=401wt.eu-S932623AbXATAOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbXATAOx (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 19:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932844AbXATAOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 19:14:53 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:53746 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932623AbXATAOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 19:14:52 -0500
Message-ID: <45B15EF6.10905@pobox.com>
Date: Fri, 19 Jan 2007 19:14:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata: PIIX3 support
References: <20070110171338.5cd555b1@localhost.localdomain>
In-Reply-To: <20070110171338.5cd555b1@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> This I believe completes the PIIX range of support for libata
> 
> This adds the table entries needed for the PIIX3, both a new PCI
> identifier and a new mode list. It also fixes an erroneous access to PCI
> configuration 0x48 on non UDMA capable chips.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied.

Please submit clean, warning-free C code in the future, rather than 
relying on Andrew to clean up after you.

	Jeff



