Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbTLEVgg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 16:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTLEVgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 16:36:36 -0500
Received: from bay9-f3.bay9.hotmail.com ([64.4.47.3]:31498 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S264376AbTLEVge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 16:36:34 -0500
X-Originating-IP: [200.141.111.28]
X-Originating-Email: [lukels@hotmail.com]
From: "A. S." <lukels@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Compiling SCSI driver (Adaptec aic7xxx)
Date: Fri, 05 Dec 2003 21:36:33 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <BAY9-F3FJkiCQ4voAHL0001b112@hotmail.com>
X-OriginalArrivalTime: 05 Dec 2003 21:36:33.0974 (UTC) FILETIME=[DA9D2560:01C3BB77]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ops, Linux kernel version 2.4.23...
after executing:
# make menuconfig
# make dep
# make bzImage
# make modules

>On Fri, 5 Dec 2003, A. S. wrote:
>
> > Compiling SCSI driver (Adaptec aic7xxx):
> >
> > aicasm_symbol.c:39: db1/db.h: No such file or directory
> >
> > No "db.h" was found in the source code.
> > It wasn't renamed, because i couldn't even find the variables used in
> > aicasm_symbol.c
> > (like DB_HASH).
> >
> > Luke
> >
> > _________________________________________________________________
> > MSN Messenger: converse com os seus amigos online.
> > http://messenger.msn.com.br
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
>in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >

_________________________________________________________________
MSN Hotmail, o maior webmail do Brasil.  http://www.hotmail.com

