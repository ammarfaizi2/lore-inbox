Return-Path: <linux-kernel-owner+w=401wt.eu-S932339AbXADKS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbXADKS4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 05:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbXADKS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 05:18:56 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43160 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932339AbXADKSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 05:18:55 -0500
Date: Thu, 4 Jan 2007 10:29:22 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: ahendry <ahendry@tusc.com.au>
Cc: linux-x25@vger.kernel.org, eis@baty.hanse.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] X.25: Trivial, SOCK_DEBUG's in x25_facilities missing
 newlines
Message-ID: <20070104102922.011ad57d@localhost.localdomain>
In-Reply-To: <1167885564.5124.98.camel@localhost>
References: <1167885564.5124.98.camel@localhost>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jan 2007 15:39:24 +1100
ahendry <ahendry@tusc.com.au> wrote:

> Trivial. Newlines missing on the SOCK_DEBUG's for X.25 facility negotiation.
> 
> Signed-off-by: Andrew Hendry <andrew.hendry@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>
