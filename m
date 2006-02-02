Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWBBOiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWBBOiN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 09:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWBBOiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 09:38:13 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18070 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751106AbWBBOiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 09:38:11 -0500
Subject: Re: DEVICE POLLING
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: kasp <waters@inbox.lv>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <293455779.20060202104554@inbox.lv>
References: <293455779.20060202104554@inbox.lv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Feb 2006 14:39:47 +0000
Message-Id: <1138891187.9861.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-02-02 at 10:45 +0200, kasp wrote:
> Hello!
> 
> I've read that *BSD like systems support device polling:
> So, are there any feature like that in linux kernel supported?

The Linux kernel does similar things for high network loads. Some serial
hardware also supports that functionality (eg comtrol rocketport).


