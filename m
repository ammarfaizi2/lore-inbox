Return-Path: <linux-kernel-owner+w=401wt.eu-S1751298AbXAIKk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbXAIKk1 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbXAIKk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:40:27 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:33569 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbXAIKk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:40:26 -0500
Message-ID: <45A37117.3030201@pobox.com>
Date: Tue, 09 Jan 2007 05:40:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ahci: Remove jmicron fixup
References: <20070108120725.5a9d63fa@localhost.localdomain>
In-Reply-To: <20070108120725.5a9d63fa@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> The AHCI set up is handled properly along with the other bits in the
> JMICRON quirk. Remove the code whacking it in ahci.c as its un-needed and
> also blindly fiddles with bits it doesn't own.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied


