Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWFOLuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWFOLuS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 07:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWFOLuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 07:50:18 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:6120 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030268AbWFOLuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 07:50:16 -0400
Message-ID: <44914973.1070909@garzik.org>
Date: Thu, 15 Jun 2006 07:50:11 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Laura Garcia <nevola@gmail.com>
CC: Laura Garcia <laura.linux@gmail.com>, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] CCISS cleanups
References: <200606141707.27404.bjorn.helgaas@hp.com>	<c6b285c60606150114h273f5ceue19bcea43937e86c@mail.gmail.com> <20060615103525.5ebc42c4@enano>
In-Reply-To: <20060615103525.5ebc42c4@enano>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laura Garcia wrote:
> Hi Bjorn,
> 
> 	Reading cciss and cpqarray driver code, I've noticed that both have very similar structure so, could it be useful to merge both drivers in only one?

Given that cpqarray hardware is not actively appearing on the market, it 
may be best to just leave that driver alone.

	Jeff




