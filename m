Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268791AbUHLUv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268791AbUHLUv3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 16:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268777AbUHLUuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 16:50:51 -0400
Received: from the-village.bc.nu ([81.2.110.252]:40917 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268755AbUHLUsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 16:48:46 -0400
Subject: Re: New concept of ext3 disk checks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: otto.wyss@orpatec.ch
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <411BAFCA.92217D16@orpatec.ch>
References: <411BAFCA.92217D16@orpatec.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092339980.22362.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 12 Aug 2004 20:46:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-12 at 18:58, Otto Wyss wrote:
> The advantage of such a concept are rather obvious, desktop systems
> don't have to use ridiculous high check interval values or disable
> checks altogether and server systems may run forever. Also checks may be
> done first on the written disk sectors. On an average loaded system,
> this way malfunctioning software are detected within minutes and
> hardware possibly within days, a rather high improvement to the current
> detection time of sometimes months.

I think it would indeed be a good project. If anyone has patches please
send them along to the linux-fsdevel list

