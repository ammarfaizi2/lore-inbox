Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263013AbTCSL3f>; Wed, 19 Mar 2003 06:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263014AbTCSL3f>; Wed, 19 Mar 2003 06:29:35 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:23728 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S263013AbTCSL3d>; Wed, 19 Mar 2003 06:29:33 -0500
Message-ID: <20030319114026.25191.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: efault@gmx.de, jeremy@goop.org
Cc: akpm@digeo.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Date: Wed, 19 Mar 2003 12:40:26 +0100
Subject: Re: [patch] sched-2.5.64-D3, more interactivity changes
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Mike Galbraith <efault@gmx.de> 
Date: 	Wed, 19 Mar 2003 09:21:00 +0100 
To: Jeremy Fitzhardinge <jeremy@goop.org> 
Subject: Re: [patch] sched-2.5.64-D3, more interactivity changes 
 
> At 11:13 PM 3/18/2003 -0800, Jeremy Fitzhardinge wrote: 
> >I'm still getting starvation problems.  If I run xmms with the "Goom" 
> >visualizer (with the window large enough that it is CPU-bound), then 
> >type a command into a shell window (say, ps), it will not run the 
> >command until I close or shrink the goom window.  xmms itself plays 
> >fine, though sometimes it fails to go to the next track, apparently for 
> >the same reason (ie, it starts the next track when I disable the 
> >visualizer). 
>  
> I'm hot on the trail (woof) of this.  If I get it working "right", are you  
> willing to test a patch?  I don't want to bug Ingo until I've got something  
> worth arm waving about ;-) 
 
I'll do :-) 
 
   Felipe 
 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
