Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266296AbTBKVFn>; Tue, 11 Feb 2003 16:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbTBKVFK>; Tue, 11 Feb 2003 16:05:10 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10624
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266286AbTBKVE6>; Tue, 11 Feb 2003 16:04:58 -0500
Subject: Re: Kill "testing by UNISYS" message
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20030210171336.GA10875@elf.ucw.cz>
References: <20030210171336.GA10875@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044969854.12906.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 11 Feb 2003 13:24:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-10 at 17:13, Pavel Machek wrote:
> -	printk(KERN_INFO "Linux NET4.0 for Linux 2.4\n");
> -	printk(KERN_INFO "Based upon Swansea University Computer Society NET3.039\n");
> -

No problem with that but please ensure the Swansea University Computer Society part is
already in, or ends up in the top of file comments so the copyright info is preserved.

Alan

