Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbTHXCNg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 22:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263701AbTHXCNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 22:13:35 -0400
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:59014 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S263682AbTHXCNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 22:13:34 -0400
Message-ID: <20030824021134.3326.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: "Arno Wagner" <wagner@tik.ee.ethz.ch>,
       "Diego Calleja Garc?a" <diegocg@teleline.es>
Cc: linux-kernel@vger.kernel.org
Date: Sun, 24 Aug 2003 03:11:34 +0100
Subject: Re: BUG: 2.6.0-test3: dmesg buffer still too small
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > b) Add a configuration option to set the buffer size 
> > >    in kernel configuration. 
> > >  
> >   (15) Kernel log buffer size (16 => 64KB, 17 => 128KB 
> >  
> >  
> > Under "general setup" at least in -test3/4 
>  
> Not displayed by "make menuconfig" and "make config"  
> unfortunately. 
 
You must enable CONFIG_DEBUG for it to show up. 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
