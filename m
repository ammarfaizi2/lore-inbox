Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266977AbUBGKIq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 05:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266983AbUBGKIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 05:08:46 -0500
Received: from leticia.terra.com.br ([200.154.55.226]:43723 "EHLO
	leticia.terra.com.br") by vger.kernel.org with ESMTP
	id S266977AbUBGKIo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 05:08:44 -0500
Date: Sat,  7 Feb 2004 07:08:42 -0300
Message-Id: <HSPLII$18EA3AADF31F597AEFE6C2F60F56E369@terra.com.br>
Subject: =?iso-8859-1?Q?Re:_[PATCH]_PSX_support_in_input/joystick/gamecon.c?=
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
From: "=?iso-8859-1?Q?iuri.f?=" <iuri.f@terra.com.br>
To: "=?iso-8859-1?Q?pnelson?=" <pnelson@andrew.cmu.edu>
Cc: "=?iso-8859-1?Q?linux-kernel?=" <linux-kernel@vger.kernel.org>
Cc: "=?iso-8859-1?Q?vojtech?=" <vojtech@suse.cz>
Cc: "=?iso-8859-1?Q?linux-joystick?=" 
	<linux-joystick@atrey.karlin.mff.cuni.cz>
X-XaM3-API-Version: 3.2 R28 (B53 pl3)
X-type: 0
X-SenderIP: 200.96.80.24
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I'll surely give it a try this weekend. 
I can't change to kernel 2.6 yet because of my damn winmodem :( 
 
---------- Cabeçalho inicial  ----------- 
 
De: Peter Nelson <pnelson@andrew.cmu.edu> 
Para: "iuri.f" <iuri.f@terra.com.br> 
Cópia: linux-kernel <linux-kernel@vger.kernel.org>,vojtech 
<vojtech@suse.cz>,linux-joystick 
<linux-joystick@atrey.karlin.mff.cuni.cz> 
Data: Fri, 06 Feb 2004 18:17:38 -0500 
Assunto: Re: [PATCH] PSX support in input/joystick/gamecon.c 
 
> iuri.f wrote: 
>  
> >Looks nice, any chance of a 2.4.22+ kernel patch?  
> >   
> > 
> Thanks.  I haven't booted into 2.4 for months now and for some 
reason it  
> doesn't want to boot back into it.  Anyway here is a port of the 
current  
> driver back to 2.4, keeping the 2.4 irq stuff and some things like  
> that.  It compiles fine and should run, but can you test it?  Also  
> vojtech should take a look at some of the name/comment changes but 
since  
> there will be no more features in 2.4 I'm sure this will never be  
> applied officially. 
>  
> -Peter 
>  

