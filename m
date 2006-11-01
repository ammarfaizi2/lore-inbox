Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945985AbWKABhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945985AbWKABhX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 20:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423923AbWKABhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 20:37:23 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:20692 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1423625AbWKABhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 20:37:22 -0500
Message-ID: <4547FA4F.1060209@pobox.com>
Date: Tue, 31 Oct 2006 20:37:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Peer Chen <pchen@nvidia.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] SCSI: Add nvidia AHCI controllers of MCP67 support to
 ahci.c
References: <15F501D1A78BD343BE8F4D8DB854566B0C42D7F3@hkemmail01.nvidia.com>
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B0C42D7F3@hkemmail01.nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peer Chen wrote:
> Resend the patch.
> Signed-off-by: Peer Chen <pchen@nvidia.com>

ACK everything Andrew Morton said:  this patch doesn't apply to the 
current kernel (2.6.19-rc4-gitX).  Please resend.

libata moves fast :)

Also, a related question:  does NVIDIA hardware use the PCI class code 
for AHCI?

	Jeff



