Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbVHZTxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbVHZTxU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbVHZTxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:53:19 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:23947 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030246AbVHZTxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:53:19 -0400
Subject: Re: [patch] IBM HDAPS accelerometer driver.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@novell.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Arjan van de Ven <arjan@infradead.org>,
       Brian Gerst <bgerst@didntduck.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1125085037.18155.95.camel@betsy>
References: <1125069494.18155.27.camel@betsy>
	 <430F5257.4010700@didntduck.org>  <1125077594.18155.52.camel@betsy>
	 <1125079311.4294.10.camel@laptopd505.fenrus.org>
	 <1125079430.18155.64.camel@betsy>
	 <1125086134.14080.13.camel@localhost.localdomain>
	 <1125084555.18155.89.camel@betsy>  <430F6E6F.5010001@pobox.com>
	 <1125085037.18155.95.camel@betsy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 26 Aug 2005 21:21:41 +0100
Message-Id: <1125087702.14080.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-08-26 at 15:37 -0400, Robert Love wrote:
> Second, we don't know a DMI-based solution will work. I'll check it out.

Another good sanity check would be tool for the right bridge chips with
device->subvendor == IBM ?

