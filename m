Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281705AbRKQGPf>; Sat, 17 Nov 2001 01:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281706AbRKQGPZ>; Sat, 17 Nov 2001 01:15:25 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:37898 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S281705AbRKQGPP>;
	Sat, 17 Nov 2001 01:15:15 -0500
Date: Fri, 16 Nov 2001 23:13:35 -0800
From: Greg KH <greg@kroah.com>
To: Kilobug <kilobug@freesurf.fr>
Cc: linux-kernel@vger.kernel.org, speedtouch@ml.free.fr
Subject: Re: [bug report] System hang up with Speedtouch USB hotplug
Message-ID: <20011116231335.A18746@kroah.com>
In-Reply-To: <3BF5C3AF.8090107@freesurf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BF5C3AF.8090107@freesurf.fr>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sat, 20 Oct 2001 06:01:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2001 at 02:55:59AM +0100, Kilobug wrote:
> 
> [4.] Kernel version (from /proc/version):
> 2.4.12-ac5 with preempt patch (and some patches from Netfilter's 
> patch-o-matic)

Does the problem happen on a kernel without the preemt patch?

thanks,

greg k-h
