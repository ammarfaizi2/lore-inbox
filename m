Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbTECPtc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 11:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbTECPtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 11:49:32 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47774
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261166AbTECPtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 11:49:32 -0400
Subject: Re: promise NEITHER IDE PORT ENABLED
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: "Javi Pardo (DAKOTA)" <dakota@dakotabcn.net>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ataraid-list@redhat.com
In-Reply-To: <3EB2E9F7.9000708@gmx.net>
References: <040101c308df$452110f0$3200000a@dakotapiv>
	 <3EA683A8.8040303@gmx.net> <036f01c30ff0$d2197fc0$3200000a@dakotapiv>
	 <3EB2E9F7.9000708@gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051974189.24562.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 May 2003 16:03:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-05-02 at 22:58, Carl-Daniel Hailfinger wrote:
> Andre, Alan,
> 
> could you please take a look at this? I thought the IDE code in
> 2.4.21-rc1 is able to force enable the ports of a promise controller.

It can - if you set the configuration option to do so

