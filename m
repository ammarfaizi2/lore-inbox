Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbVCCU0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVCCU0G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVCCUWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:22:13 -0500
Received: from curlew.cs.man.ac.uk ([130.88.13.7]:46093 "EHLO
	curlew.cs.man.ac.uk") by vger.kernel.org with ESMTP id S262376AbVCCUSv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 15:18:51 -0500
Message-ID: <42277195.8@gentoo.org>
Date: Thu, 03 Mar 2005 20:20:37 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, philipp.gortan@tttech.com
Subject: Re: netdev-2.6 queue updated
References: <4226BD3B.9080604@pobox.com>
In-Reply-To: <4226BD3B.9080604@pobox.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1D6wmU-000Giv-7V*SsS820ehW9w*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> <philipp.gortan:tttech.com>:
>   o [netdrvr 8139cp] add PCI ID

This one seems to be already present in 2.6.11 under a different name 
(PCI_DEVICE_ID_TTTECH_MC322). Also, the corresponding entry in pci_ids.h is 
not in the order of the file.

Daniel
