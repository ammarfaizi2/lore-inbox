Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266815AbUFYRbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266815AbUFYRbM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 13:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266819AbUFYRbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 13:31:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29337 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266815AbUFYRau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 13:30:50 -0400
Date: Fri, 25 Jun 2004 10:30:20 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: cieciwa@alpha.zarz.agh.edu.pl, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Subject: Re: [SPARC64] kernel 2.6.7+cset-20040625_0611 = ERROR
Message-Id: <20040625103020.25b37791.davem@redhat.com>
In-Reply-To: <20040625030502.40e25d42.akpm@osdl.org>
References: <Pine.LNX.4.58L.0406251320310.6037@alpha.zarz.agh.edu.pl>
	<20040625030502.40e25d42.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2004 03:05:02 -0700
Andrew Morton <akpm@osdl.org> wrote:

> "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl> wrote:
> >
> > make[1]: *** [arch/sparc64/kernel/process.o] Error 1
> >  make: *** [arch/sparc64/kernel] Error 2
> 
> here's t'other:

Ok, is it only gcc-3.4 and later that spit out these warnings?
I've been doing gcc-3.3 builds without incident... oh or maybe
only on SMP.  I haven't tried a uniprocessor build in a while.
