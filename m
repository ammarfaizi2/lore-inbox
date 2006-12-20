Return-Path: <linux-kernel-owner+w=401wt.eu-S1030294AbWLTTTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWLTTTj (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbWLTTTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:19:38 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:34918 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030304AbWLTTTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:19:36 -0500
Message-ID: <45898CC4.9010805@pobox.com>
Date: Wed, 20 Dec 2006 14:19:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Peer Chen <pchen@nvidia.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] sata_nv & ahci: Move some IDs from sata_nv.c to ahci.c
References: <15F501D1A78BD343BE8F4D8DB854566B07FC61A9@hkemmail01.nvidia.com>
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B07FC61A9@hkemmail01.nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peer Chen wrote:
> Resend the patch.
> The content of memory map io of BAR5 have been change from MCP65 then sata_nv can't work fine on the platform based on MCP65 and MCP67,so move their IDs from sata_nv.c to ahci.c.
> Please check attachment for new patch,thanks.
> 
> Signed-off-by: Peer Chen <pchen@nvidia.com>

Patch applied, manually.

For future patches,

1) Please do not quote the original message

2) Please include patches inline, rather than as an attachment.

	Jeff



