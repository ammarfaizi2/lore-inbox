Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTIRMge (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 08:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbTIRMge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 08:36:34 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:2733 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261226AbTIRMge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 08:36:34 -0400
Subject: Re: Cirrus Logic Crystal CS4281 PCI Audio
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Hardt <dh@id.cbs.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030918.141638.104060144.dh@id.cbs.dk>
References: <20030918.141638.104060144.dh@id.cbs.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063888503.15957.23.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Thu, 18 Sep 2003 13:35:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-18 at 13:16, Daniel Hardt wrote:
> I have an IBM X21 thinkpad with a Cirrus Logic Crystal CS4281 PCI
> Audio sound chip.  Our system guy has not been able to get it to work
> under linux.  below is the lspci output.  any ideas would be much
> appreciated.  Please cc me.

The cs4281 is supported and has a proper driver. Unfortunately you don't
give any info on what was tried orwhat problems were hit

