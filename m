Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUDYOUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUDYOUy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 10:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUDYOUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 10:20:54 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:39693 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263093AbUDYOUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 10:20:53 -0400
Date: Sun, 25 Apr 2004 15:20:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Swamy_Gautham@emc.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help in debugging Memory corruption issue on Hugemem kernel
Message-ID: <20040425152052.A26995@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Swamy_Gautham@emc.com, linux-kernel@vger.kernel.org
References: <206992158A64DC41A6CFBC58327CE94C1F6604@inba1mx1.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <206992158A64DC41A6CFBC58327CE94C1F6604@inba1mx1.corp.emc.com>; from Swamy_Gautham@emc.com on Sun, Apr 25, 2004 at 03:17:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2004 at 03:17:26PM +0100, Swamy_Gautham@emc.com wrote:
> Please CC me when replying, thanks.
> 
> The issue is with a Multipathing driver on RH-AS-3.0
> (2.4.21-9.0.1.ELhugemem) kernel.
> The driver is corrupting memory which leads to a panic at a later point in
> time when a "tar" or "cp" command is run. This happens only on hugemem
> kernels and not on SMP kernels.
> 
> Happens only with machines that have at least 6GB of physical memory.

Could you please post the url to the mentioned driver's sorce?

