Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbVIGLzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVIGLzV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 07:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVIGLzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 07:55:21 -0400
Received: from mx1.actcom.co.il ([192.114.47.64]:15574 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S1751188AbVIGLzV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 07:55:21 -0400
Date: Wed, 7 Sep 2005 14:54:41 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: M?rius Mont?n <Marius.Monton@uab.es>, linux-kernel@vger.kernel.org
Subject: Re: 'virtual HW' into kernel (SystemC)
Message-ID: <20050907115441.GC30242@granada.merseine.nu>
References: <431EC16B.2040604@uab.es> <431ED1B9.7040407@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431ED1B9.7040407@pobox.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 07:40:41AM -0400, Jeff Garzik wrote:

> No need for a set of tools.  As long as your SystemC simulator simulates 
> an entire platform -- CPU, DRAM, etc. -- then you can boot Linux on the 
> simulated platform.

Even if it doesn't, hooking SystemC into something that does boot
Linux such as qemu strikes me as a much easier approach than modifying
a kernel running on bare metal to also use "virtual" hardware.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

