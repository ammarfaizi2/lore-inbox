Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261520AbTCKSuZ>; Tue, 11 Mar 2003 13:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261521AbTCKSuZ>; Tue, 11 Mar 2003 13:50:25 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26304
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261520AbTCKSuY>; Tue, 11 Mar 2003 13:50:24 -0500
Subject: Re: kernel bug page_alloc.c 2.4.18-14
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jeff@AmeriCom.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030311183138.13152.qmail@solo.americom.com>
References: <20030311183138.13152.qmail@solo.americom.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047413311.19953.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 11 Mar 2003 20:08:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-11 at 18:31, jeff@AmeriCom.com wrote:
> This dual CPU system will stay up for a few days, and then it starts reporting these
> errors to the console, shortly after these messages start appearing it will lock up.
> Below is the output from dmesg. Below that is my system info. Is there a patch for
> this? This is the standard redhat 8.0 kernel (2.4.18-14smp).

>From the trace its hard to tell, its random corruption by the look of
it. Could be hw or sw. The best place to file bugs on Red Hat kernels
is http://bugzilla.redhat.com. There is a newer kernel update but I 
don't know if it fixes anything you might be hitting from the info
given.

