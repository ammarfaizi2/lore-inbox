Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266895AbUIJIQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266895AbUIJIQw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267205AbUIJIQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:16:52 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:57051 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266895AbUIJIQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:16:51 -0400
Date: Fri, 10 Sep 2004 17:18:46 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] missing pci_disable_device()
In-reply-to: <20040909173349.GA14633@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, bjorn.helgaas@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <41416366.8070000@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
References: <413D0E4E.1000200@jp.fujitsu.com>
 <1094550581.9150.8.camel@localhost.localdomain>
 <413E7925.1010801@jp.fujitsu.com>
 <1094647195.11723.5.camel@localhost.localdomain>
 <413FF05B.8090505@jp.fujitsu.com> <20040909062009.GD10428@kroah.com>
 <41403075.1010103@jp.fujitsu.com> <20040909173349.GA14633@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> I like Alan's advice.  Also, a patch for the uhci-hcd driver would be
> nice to have :)
> 

Sure, I'll make a patch for the uhci-hcd driver (and ehci-hcd,
e1000, etc. also).

Thanks,
Kenji Kaneshige

