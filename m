Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbTFXTya (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 15:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbTFXTya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 15:54:30 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:60715 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262368AbTFXTyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 15:54:04 -0400
Date: Tue, 24 Jun 2003 13:09:02 -0700
From: Andrew Morton <akpm@digeo.com>
To: "jds" <jds@soltis.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Panic in 2.5.73-mm1 OOps part.
Message-Id: <20030624130902.3d9090e9.akpm@digeo.com>
In-Reply-To: <20030624191740.M38428@soltis.cc>
References: <20030624191740.M38428@soltis.cc>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jun 2003 20:08:13.0634 (UTC) FILETIME=[579E7220:01C33A8C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"jds" <jds@soltis.cc> wrote:
>
> 
> 
> Hi Andrew:
> 
> 
>     I have kernel panic when boot with kernel 2.5.73-mm1, in kernel 2.5.73
> working good.
> 

Please disable CONFIG_BLK_DEV_NBD.   We're working on it.
