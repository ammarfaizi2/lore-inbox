Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbUK3TTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbUK3TTF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbUK3TTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:19:05 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:3998 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262252AbUK3TTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:19:02 -0500
Subject: Re: [patch 6/6] s390: qeth network driver.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101837055.25617.70.camel@localhost.localdomain>
References: <20041130151013.GG4758@mschwid3.boeblingen.de.ibm.com>
	 <41ACB253.9090202@pobox.com>
	 <1101837055.25617.70.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101838531.25628.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 18:15:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-30 at 17:50, Alan Cox wrote:
> 
> 	If(i < PAGE_SIZE - errorlen)
> 		i += snprintf(buf + i, PAGE_SIZE - i, ...)

PAGE_SIZE - i - errorlen of course

