Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbUKWScA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbUKWScA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 13:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbUKWS34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 13:29:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33200 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261491AbUKWS2I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 13:28:08 -0500
Message-ID: <41A38128.90305@pobox.com>
Date: Tue, 23 Nov 2004 13:27:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mathias Kretschmer <posting@blx4.net>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VIA VT610 IDE support for 2.4.28 (trivial)
References: <41A2E581.2010305@blx4.net>
In-Reply-To: <41A2E581.2010305@blx4.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathias Kretschmer wrote:
> hi,
> 
> I found an older version of this patch (against 2.4.22) on some website. 
> After a little bit of editing it applied cleanly to 2.4.27 (and now 
> 2.4.28). It works fine for me on a ASUS P4P800-Deluxe with 4x 300GB disks.
> 
> Maybe someone finds this patch helpful. Any reason why the original 
> patch did not make it into the kernel ?

Why not add it to the existing via82cxxx driver, and get better 
performance and device tuning?

	Jeff



