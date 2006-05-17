Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWEQSnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWEQSnn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 14:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWEQSnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 14:43:43 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40633 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750899AbWEQSnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 14:43:42 -0400
Subject: Re: [PATCH] ignore partition table on disks with AIX label
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olaf Hering <olh@suse.de>
Cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060517183710.GA28931@suse.de>
References: <20060517081314.GA20415@suse.de>
	 <200605170853.k4H8rn8K009466@turing-police.cc.vt.edu>
	 <20060517091056.GA21219@suse.de>
	 <200605171014.k4HAETHT011371@turing-police.cc.vt.edu>
	 <20060517183710.GA28931@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 17 May 2006 19:56:27 +0100
Message-Id: <1147892187.10470.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-05-17 at 20:37 +0200, Olaf Hering wrote:
> A big company who is all hot about Linux expressed no interrest so far
> to make AIX volumes readable in Linux.

All we want to know initially is how to correctly spot AIX volumes. As I
understand it the fs on them isn't from IBM anyway so they probably
can't tell us how it works.

Alan

