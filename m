Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030355AbWHXGoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbWHXGoG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 02:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030353AbWHXGoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 02:44:06 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:57319 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030352AbWHXGoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 02:44:03 -0400
Message-ID: <44ED4AA2.2030200@pobox.com>
Date: Thu, 24 Aug 2006 02:43:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [libata patch] cleanup drivers/ata/Kconfig
References: <20060821220053.GR11651@stusta.de>
In-Reply-To: <20060821220053.GR11651@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I applied most of this, manually, since the patch isn't broken up into 
#upstream and #pata-driver branch changes.

	Jeff



