Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263509AbTDGPiS (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 11:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263516AbTDGPiS (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 11:38:18 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:25237
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263509AbTDGPiQ (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 11:38:16 -0400
Subject: Re: [PATCH][RESEND] socket interface for IPMI against 2.5.66-bk
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Corey Minyard <minyard@acm.org>
Cc: Louis Zhuang <louis.zhuang@linux.co.intel.com>,
       OPENIPMIML <openipmi-developer@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3E9196B6.8030601@acm.org>
References: <1049363835.1168.6.camel@hawk.sh.intel.com>
	 <3E8C63D4.8040807@mvista.com> <1049433965.1165.2.camel@hawk.sh.intel.com>
	 <3E8D9CD2.8060506@acm.org> <1049678799.1165.24.camel@hawk.sh.intel.com>
	 <3E9196B6.8030601@acm.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049727074.2967.73.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Apr 2003 15:51:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Just curious, should we add copyright even when I have announced it by
> >'MODULE_LICENSE("GPL")'? I dislike too many leagal text in code...
> 
> I guess it's up to you, but you had added the header in all files but
> that one.

It is a good idea to do so (although its a matter of taste too). It
doesn't need a foot long pile of blurb. Its quite sufficient to say
Copyright (C) <year> <author) and state where the GPL is found.

Some people advise that the no warranty piece by present in each file
and you'll see IBM I think do that.


