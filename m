Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752849AbWKCAEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbWKCAEK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 19:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752845AbWKCAEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 19:04:09 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:11729 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752843AbWKCAEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 19:04:08 -0500
Message-ID: <454A8774.2030009@garzik.org>
Date: Thu, 02 Nov 2006 19:04:04 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>, Peer Chen <pchen@nvidia.com>
Subject: Re: [git patches] libata: some last minute PCI IDs
References: <20061102230301.GA29659@havoc.gtf.org> <20061102153337.7e7c3e06.akpm@osdl.org>
In-Reply-To: <20061102153337.7e7c3e06.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I think you'll find we're missing definitions for
> PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE (at least).


Whoops.  This is what happens when you deal with manually extracted MIME 
patches :/  That was sitting around uncommitted in my tree.

Checked in -- though only the _IDE symbol is needed.

	Jeff


