Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263789AbTE3QZd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 12:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbTE3QZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 12:25:33 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29916
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263789AbTE3QZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 12:25:32 -0400
Subject: Re: [PATCH] linux-2.4.21-rc5-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matt Hartley <matthartley@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030530083327.15157.qmail@web14002.mail.yahoo.com>
References: <20030530083327.15157.qmail@web14002.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054309256.23566.49.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 May 2003 16:40:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-05-30 at 09:33, Matt Hartley wrote:
> Alan,
> 
> After noticing that drivers/pci/pci.ids was over nine months old, I
> grabbed the latest list off of http://pciids.sourceforge.net, modded it
> to include a few recent submissions and to fix a couple of broken
> lines, and created this patch. 

Mostly merged - dropped a couple of bits where it backed out kernel
changes that seem to have failed to reach the master list

