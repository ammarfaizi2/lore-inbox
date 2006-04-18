Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWDRRtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWDRRtr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 13:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWDRRtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 13:49:47 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:31407 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932216AbWDRRtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 13:49:46 -0400
Message-ID: <444526B4.6030903@garzik.org>
Date: Tue, 18 Apr 2006 13:49:40 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Orion Poplawski <orion@cora.nwra.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to determine speed of PCI-X device
References: <e23831$1h6$1@sea.gmane.org>
In-Reply-To: <e23831$1h6$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.0 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.0 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Orion Poplawski wrote:
> Is there a generic way in Linux to determine the bus speed that a 
> particular PCI/PCI-X device actually operating at?

Not really.  As an additional complication, the bus speed may vary...

	Jeff



