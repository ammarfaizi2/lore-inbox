Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVACSEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVACSEz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVACSBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 13:01:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65206 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261693AbVACSBR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 13:01:17 -0500
Message-ID: <41D9885B.9090304@pobox.com>
Date: Mon, 03 Jan 2005 13:00:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Wong <kernel@implode.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Promise IDE DMA issue
References: <20050102173704.GA14056@gambit.implode.net>
In-Reply-To: <20050102173704.GA14056@gambit.implode.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Wong wrote:
> I recently upgraded fron a nVidia nForce2 MCP-T based A7NX-DX
> motherboard to an A8V DX, Via K8T800 Pro.  Now occassionally, I get 
> DMA issues on a drive attached to a Promise 133 TX2 controller (20269).

I would try fiddling with BIOS settings, and make sure you have the 
latest BIOS.

	Jeff



