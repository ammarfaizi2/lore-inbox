Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbTJAOuP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTJAOuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:50:14 -0400
Received: from mailtest.ifxnw.cl ([216.241.0.135]:47037 "EHLO mail.ifxnw.cl")
	by vger.kernel.org with ESMTP id S262298AbTJAOuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:50:08 -0400
Date: Wed, 1 Oct 2003 10:46:47 -0400
From: Oscar Peredo <oscar.peredo@bunkerchile.net>
To: linux-kernel@vger.kernel.org
Subject: Re: How to use module in 2.6
Message-Id: <20031001104647.33477f6f.oscar.peredo@bunkerchile.net>
In-Reply-To: <1065009486.1144.50.camel@ocsy>
References: <1065006634.1144.39.camel@ocsy>
	<200310011136.24176.johann.lombardi@bull.net>
	<1065009486.1144.50.camel@ocsy>
Organization: Bunkerchile 
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[Ve)k4kR)7 DN3VM-LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3 Oyv%0J(}_6</ D.eu"&w8%ArL0I8AD'UKOxF0JODr/<g]
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Oct 2003 15:58:06 +0400
ocsy <ocsy@rusbiz.com> wrote:

> >Did you upgrade your module-init-tools (insmod, lsmod, ....) ?
> >(http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
> 
> Ok!I do that now))
> I think it's possible that you can help me to understand what different
> between old module for kernell 2.4 and new module fo 2.6?
> And where can I look for the modutils ver 2.6?
> ocsy
> 
the lwn webpage have a article on modules of kernel 2.6 (http://lwn.net/Articles/driver-porting/ ,exactly ) and talk about on some differences with 2.6 kernel

the new version of kernel changed much things, the load module for example, and scheduling were the most commented.

the module-init-tools that you need, you can download from  http://www.kernel.org/pub/linux/kernel/people/rusty/modules/module-init-tools-0.9.15-pre2.tar.gz it is last version 

Oscar Peredo
