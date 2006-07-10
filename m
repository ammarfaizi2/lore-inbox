Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422722AbWGJRbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422722AbWGJRbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 13:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422724AbWGJRbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 13:31:46 -0400
Received: from xenotime.net ([66.160.160.81]:22733 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422722AbWGJRbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 13:31:46 -0400
Date: Mon, 10 Jul 2006 10:34:33 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Matt LaPlante <kernel1@cyberdogtech.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 18-rc1] Fix typos in /Documentation : 'A'
Message-Id: <20060710103433.37420ae2.rdunlap@xenotime.net>
In-Reply-To: <20060710130549.ed48127a.kernel1@cyberdogtech.com>
References: <20060710130549.ed48127a.kernel1@cyberdogtech.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 13:05:49 -0400 Matt LaPlante wrote:

> This patch fixes typos in various Documentation txts. This patch addresses some words starting with the letter 'A'.
> 
> Signed-off-by: Matt LaPlante <kernel1@cyberdogtech.com>

Hi,
Looks mostly good.  I think it would be OK to fix other typos
on the same lines as the patches... see below.


> diff -ru a/Documentation/fb/sstfb.txt b/Documentation/fb/sstfb.txt
> --- a/Documentation/fb/sstfb.txt	2006-07-08 14:12:27.000000000 -0400
> +++ b/Documentation/fb/sstfb.txt	2006-07-10 12:14:50.000000000 -0400
> @@ -161,7 +161,7 @@
>  	- Buy more coffee.
>  	- test/port to other arch.
>  	- try to add panning using tweeks with front and back buffer .
> -	- try to implement accel on voodoo2 , this board can actualy do a 
> +	- try to implement accel on voodoo2 , this board can actually do a 

No space before comma.

>  	  lot in 2D even if it was sold as a 3D only board ...
>  
>  ghoz.
> diff -ru a/Documentation/networking/pktgen.txt b/Documentation/networking/pktgen.txt
> --- a/Documentation/networking/pktgen.txt	2006-07-08 14:13:34.000000000 -0400
> +++ b/Documentation/networking/pktgen.txt	2006-07-10 12:19:44.000000000 -0400
> @@ -7,7 +7,7 @@
>  
>  Enable CONFIG_NET_PKTGEN to compile and build pktgen.o either in kernel
>  or as module. Module is preferred. insmod pktgen if needed. Once running
> -pktgen creates a thread on each CPU where each thread has affinty it's CPU.
> +pktgen creates a thread on each CPU where each thread has affinity it's CPU.

its
or
to its

>  Monitoring and controlling is done via /proc. Easiest to select a suitable 
>  a sample script and configure.
>  
> diff -ru a/Documentation/scsi/ppa.txt b/Documentation/scsi/ppa.txt
> --- a/Documentation/scsi/ppa.txt	2006-07-08 14:13:34.000000000 -0400
> +++ b/Documentation/scsi/ppa.txt	2006-07-10 12:07:39.000000000 -0400
> @@ -3,7 +3,7 @@
>  General Iomega ZIP drive page for Linux:
>  http://www.torque.net/~campbell/
>  
> -Driver achive for old drivers:
> +Driver archive for old drivers:
>  http://www.torque.net/~campbell/ppa/

dead URL

>  Linux Parport page (parallel port)

---
~Randy
