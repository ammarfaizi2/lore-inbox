Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261725AbSJ2JIU>; Tue, 29 Oct 2002 04:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261728AbSJ2JIU>; Tue, 29 Oct 2002 04:08:20 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:42706 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261725AbSJ2JIT>; Tue, 29 Oct 2002 04:08:19 -0500
Subject: Re: overcommit-accounting
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021029031918.43126.qmail@web20008.mail.yahoo.com>
References: <20021029031918.43126.qmail@web20008.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Oct 2002 09:33:45 +0000
Message-Id: <1035884025.5852.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-29 at 03:19, Kenny Simpson wrote:
> In linux/Documentation/vm/overcommit-accounting I see
> the following:
> "The Linux kernel supports four overcommit handling
> modes
> 
> 0 - Heuristic ...
> 1 - No overcommit ...
> 2 - (NEW) strict overcommit...
> "
> 
> Where is number 3 ?

Robert removed number 3 from 2.5 and I guess he missed one of the
comments 8)

