Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbUDFMd6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 08:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263794AbUDFMd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 08:33:57 -0400
Received: from ns.suse.de ([195.135.220.2]:27081 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263787AbUDFMdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 08:33:54 -0400
Subject: Re: reiserfs errors with 2.6.5-rc1-mm2
From: Chris Mason <mason@suse.com>
To: equi-NoX <equi-NoX@wanadoo.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Maurin <thomas.maurin@wanadoo.fr>
In-Reply-To: <1081228317.1636.64.camel@ender.WORKGROUP>
References: <1081228317.1636.64.camel@ender.WORKGROUP>
Content-Type: text/plain
Message-Id: <1081254739.4993.82.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Apr 2004 08:32:19 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-06 at 01:11, equi-NoX wrote:
> oops excuse me :/
> 
> This is one, I can send you others whether you want.

Ok, you need to grab the latest reiserfsprogs from ftp.namesys.com and
run reiserfsck.

It's really strange that you've got so many messages about freeing a
block that is already free for the same two block numbers.  Please send
along the results of the reiserfsck when you're done.

-chris


