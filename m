Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbWHXG45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWHXG45 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 02:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbWHXG45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 02:56:57 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:31208 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030366AbWHXG44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 02:56:56 -0400
Message-ID: <44ED4DB5.10400@pobox.com>
Date: Thu, 24 Aug 2006 02:56:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] libata : Add 40pin "short" cable support, honour drive
 side speed detection
References: <1156188229.18887.56.camel@localhost.localdomain>
In-Reply-To: <1156188229.18887.56.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACK, but you need to split this up into core (#upstream) and PATA 
(#pata-drivers) patches.


