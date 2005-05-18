Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbVERUoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVERUoI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 16:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVERUoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 16:44:07 -0400
Received: from mail.tyan.com ([66.122.195.4]:29956 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262367AbVERUnw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 16:43:52 -0400
Message-ID: <3174569B9743D511922F00A0C943142309F80FF6@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Diego Calleja <diegocg@gmail.com>
Cc: rminnich@lanl.gov, ebiederman@lnxi.com, stepan@openbios.org,
       ollie@lanl.gov, linuxbios@openbios.org, linux-tiny@selenic.com,
       linux-kernel@vger.kernel.org
Subject: RE: Next step with LinuxBIOS
Date: Wed, 18 May 2005 14:05:21 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good. spare 40k. I can put IB driver in it now.

YH

 

> -----Original Message-----
> From: Diego Calleja [mailto:diegocg@gmail.com] 
> Sent: Wednesday, May 18, 2005 1:21 PM
> To: YhLu
> Cc: rminnich@lanl.gov; ebiederman@lnxi.com; 
> stepan@openbios.org; ollie@lanl.gov; linuxbios@openbios.org; 
> linux-tiny@selenic.com; linux-kernel@vger.kernel.org
> Subject: Re: Next step with LinuxBIOS
> 
> El Wed, 18 May 2005 12:42:31 -0700,
> YhLu <YhLu@tyan.com> escribió:
> 
> > 3. smp ( i need apic...)
> 
> Why? Can't you use "Local APIC support on uniprocessors" 
> (CONFIG_X86_UP_APIC)?
> 
