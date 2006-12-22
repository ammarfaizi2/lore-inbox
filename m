Return-Path: <linux-kernel-owner+w=401wt.eu-S1945959AbWLVIIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945959AbWLVIIH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 03:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945965AbWLVIIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 03:08:07 -0500
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:1620 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1945959AbWLVIIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 03:08:06 -0500
Date: Fri, 22 Dec 2006 09:08:06 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Alexander van Heukelum <heukelum@fastmail.fm>,
       "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Message-Id: <20061222090806.3ae56579.khali@linux-fr.org>
In-Reply-To: <20061221204408.GA7009@in.ibm.com>
References: <20061220141808.e4b8c0ea.khali@linux-fr.org>
	<m1tzzqpt04.fsf@ebiederm.dsl.xmission.com>
	<20061220214340.f6b037b1.khali@linux-fr.org>
	<m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com>
	<20061221101240.f7e8f107.khali@linux-fr.org>
	<20061221145922.16ee8dd7.khali@linux-fr.org>
	<1166723157.29546.281560884@webmail.messagingengine.com>
	<20061221204408.GA7009@in.ibm.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On Fri, 22 Dec 2006 02:14:08 +0530, Vivek Goyal wrote:
> Jean, can you please upload some more files. Should give some more idea
> about what happened in your environment.
> 
> arch/i386/boot/vmlinux.bin
> arch/i386/boot/compressed/piggy.o
> arch/i386/boot/compressed/head.o

Sure, here they are:
http://jdelvare.pck.nerim.net/linux/relocatable-bug/

Thanks,
-- 
Jean Delvare
