Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbVIDD6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbVIDD6N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 23:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbVIDD6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 23:58:13 -0400
Received: from fsmlabs.com ([168.103.115.128]:9882 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S1750855AbVIDD6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 23:58:12 -0400
Date: Sat, 3 Sep 2005 20:57:52 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Kyuma Ohta <whatisthis@jcom.home.ne.jp>
cc: spam.david.trap@unsolicited.net,
       Linux Kernel <linux-kernel@vger.kernel.org>, bonganilinux@mweb.co.za
Subject: Re: [x86_64] Exception when using powernowd.
In-Reply-To: <20050903.191053.-1350500431.whatisthis@jcom.home.ne.jp>
Message-ID: <Pine.LNX.4.63.0509032054110.3393@r3000.fsmlabs.com>
References: <20050903.021820.1300541056.whatisthis@jcom.home.ne.jp>
 <43195FF4.7000207@unsolicited.net> <20050903.191053.-1350500431.whatisthis@jcom.home.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Sep 2005, Kyuma Ohta wrote:

> Thanx David,
> 
> Written by David Ranson <spam.david.trap@unsolicited.net>
>    at Sat, 03 Sep 2005 09:33:56 +0100 :
> Subject: Re: [x86_64] Exception when using powernowd.
> 
> spam.david.trap> Kyuma Ohta wrote:
> spam.david.trap> 
> spam.david.trap> 
> spam.david.trap> >>Hi,
> spam.david.trap> >>
> spam.david.trap> >>I'm using MSI K8T Neo2 (VIA K8T800 chipset) and Athlon64 3000+
> spam.david.trap> >>with  linux x86_64 2.6.13 kernel and Debian/sid.
> spam.david.trap> >>  
> spam.david.trap> >>
> spam.david.trap> >  
> spam.david.trap> >
> spam.david.trap> I'm using a K8T Neo2 FIR with the same processor and powernow-k8. Up
> spam.david.trap> with 2.6.13 since Sunday, no problems noted. Mine is a SuSE 9.1 based
> spam.david.trap> system though.
> spam.david.trap> 
> spam.david.trap> Maybe BIOS related??
> 
> I thought this problem,too.
> 
> But,I was upgrade BIOS from v3.3 to v9.2,this issue has happened yet.
> 
> # And,I have to put "pnpacpi=off" to kernel boot line to 
> # use w83627ths sensor (-_-;
> 
> When upgrade X 6.8.2-4 to 6.8.2-5(or after),this issue has often happend.
> I'm using nVidia Geforce 5200 as Display adapter,but this issue
> has happend bot Debian's driver and nVidia's driver.

I saw something very related in one of Bongani's posts on kernel bugzilla;

http://bugzilla.kernel.org/show_bug.cgi?id=4851 (scroll to the bottom)

Is there a specific kernel version which started this?

Thanks,
	Zwane
