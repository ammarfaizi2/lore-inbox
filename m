Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268334AbUIBTYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268334AbUIBTYP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 15:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268341AbUIBTYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 15:24:15 -0400
Received: from the-village.bc.nu ([81.2.110.252]:60560 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268334AbUIBTYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:24:14 -0400
Subject: Re: kernel bug: 2.6.8.1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Piotr Banasik <piotr@t-p-l.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200409021158.15192.piotr@t-p-l.com>
References: <200409021158.15192.piotr@t-p-l.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094149325.5726.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 19:22:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-02 at 19:58, Piotr Banasik wrote:
> [1.] One line summary of the problem:  
> abnormaly slow download speeds (~10k/s)
> [2.] Full description of the problem/report: 
> any download .. for example: 
> http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.1.tar.bz2 .. is throttled 
> down to 10k/s

See http://lwn.net/Articles/92727/
