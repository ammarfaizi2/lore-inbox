Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945976AbWKABjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945976AbWKABjZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 20:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945988AbWKABjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 20:39:25 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:27860 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1945976AbWKABjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 20:39:24 -0500
Message-ID: <4547FACA.4010100@garzik.org>
Date: Tue, 31 Oct 2006 20:39:22 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Peer Chen <pchen@nvidia.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Kuan Luo <kluo@nvidia.com>
Subject: Re: [PATCH] SCSI: Add the SGPIO support for sata_nv.c
References: <15F501D1A78BD343BE8F4D8DB854566B0C42D636@hkemmail01.nvidia.com>
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B0C42D636@hkemmail01.nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peer Chen wrote:
> The following SGPIO patch for sata_nv.c is based on 2.6.18 kernel.
> Signed-off by: Kuan Luo <kluo@nvidia.com>

ACK what Christoph Hellwig said:  please describe in detail what sgpio 
is, and why it is needed.

This is a non-trivial patch, with basically no explanation at all.

	Jeff



