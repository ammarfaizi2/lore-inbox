Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbTJMRcz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 13:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTJMRcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 13:32:54 -0400
Received: from felicity.nni.com ([216.107.0.51]:45379 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id S261762AbTJMRcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 13:32:51 -0400
X-Scan: Scanned for Virus By NuNet
Date: Mon, 13 Oct 2003 13:32:39 -0400
From: jhigdon <jhigdon@nni.com>
To: larry@tamiweb.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Duron 1GB memory problem
Message-Id: <20031013133239.482645d1.jhigdon@nni.com>
In-Reply-To: <1066059458.16230.22.camel@laptop.minfin.bg>
References: <1066059458.16230.22.camel@laptop.minfin.bg>
Organization: w3dev
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Oct 2003 18:37:38 +0300
Kostadin Karaivanov <larry@tamiweb.com> wrote:

> 	1. After upgrading my memory up to 1BG (2x512MB SDRAM) previosly 512MB
> (2x256MB SDRAM) I try to boot 2.6.0-test5 compiled without highmem
> support with boot-time option mem=512M and I got an Oops right before
> the checks for memory (15th-16th row of dmesg).
> It can't boot without mem=512M option even.
>  	
> 	2. 2.4.20 (without highmem support) boots fine with same option, but
> can't boot without it (?same? Oops).
> 	
> 	3. 2.6.0-test7 _WITH_ highmem enabled boots but I get 2 kernel Oops for
> 24 hours.
> 	
> 	4. 2.6.0-test5 _with_ highmem reboots itself before getting to login
> prompt,  I was told  about this by my hosting support.
> 	
> 	5. 2.4.22 with high mem works fine... for now
> 
> 	
> 	1, 2, 3 had happaned in my presence.
> 	I can't provide traces. It is productional server.

but you can run a 2.6.0-testX kernel on it? dmesg and .config would probably help too

> 
> wwell Larry
> 


