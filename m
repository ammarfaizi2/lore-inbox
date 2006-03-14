Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751920AbWCNBRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbWCNBRF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 20:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbWCNBRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 20:17:04 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61398 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751920AbWCNBRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 20:17:01 -0500
Subject: Re: New libata PATA patch for 2.6.16-rc1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Boot <bootc@bootc.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <30715A89-26A9-4B93-B17F-33C3F407B1C8@bootc.net>
References: <1142262431.25773.25.camel@localhost.localdomain>
	 <30715A89-26A9-4B93-B17F-33C3F407B1C8@bootc.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Mar 2006 01:23:17 +0000
Message-Id: <1142299397.25773.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-03-14 at 00:39 +0000, Chris Boot wrote:
> pata_via detects my HP Colorado 5GB again, although I still haven't  
> had a chance to test it yet: tapes are on back order. The DVD-RW also  

Good to know

> gets detected and haven't tested yet but I don't doubt it'll work  
> since it has worked fine for me since it was detected. I notice the  
> driver seems much more verbose now as well.

Debug bits - they will go away again shortly.


