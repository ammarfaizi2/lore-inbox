Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTKWUUq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 15:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbTKWUUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 15:20:46 -0500
Received: from mta10.adelphia.net ([68.168.78.202]:43731 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S263452AbTKWUUp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 15:20:45 -0500
Subject: Re: DRI and AGP on 2.6.0-test9
From: Aubin LaBrosse <arl8778@rit.edu>
To: Dave Jones <davej@redhat.com>
Cc: Aubin LaBrosse <arl8778@ritvax.isc.rit.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20031123193724.GA24957@redhat.com>
References: <1069571959.9574.46.camel@rain.rh.rit.edu>
	 <20031123193724.GA24957@redhat.com>
Content-Type: text/plain
Message-Id: <1069618843.4522.4.camel@rain.rh.rit.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 23 Nov 2003 15:20:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-11-23 at 14:37, Dave Jones wrote:
>  > of particular worry to me, though i'm not a kernel hacker, is the line
>  > [agp] AGP not available.
> 
> Did you modprobe the amd-k7-agp module as well as agpgart ?
> 
> 		Dave
> 
sigh.  sorry Dave - got it with that module.  though i swear it didn't
work either when compiled into the kernel (as that was my first test,
though that was with 2.6.0-test9 and not -mm5 that i am running now. 

anyway, problem solved, sorry for the noise and thanks for your help
guys

-Aubin

