Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVGaXsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVGaXsV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 19:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVGaXsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 19:48:21 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:5512 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262131AbVGaXsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 19:48:20 -0400
Date: Sun, 31 Jul 2005 19:48:33 -0400
From: Frank Peters <frank.peters@comcast.net>
To: Andrew Morton <akpm@osdl.org>
Cc: vojtech@suse.cz, mkrufky@m1k.net, linux-kernel@vger.kernel.org
Subject: Re: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
Message-Id: <20050731194833.184b5b11.frank.peters@comcast.net>
In-Reply-To: <20050731134245.742b9fc2.akpm@osdl.org>
References: <20050624113404.198d254c.frank.peters@comcast.net>
	<42BC306A.1030904@m1k.net>
	<20050624125957.238204a4.frank.peters@comcast.net>
	<42BC3EFE.5090302@m1k.net>
	<20050728222838.64517cc9.akpm@osdl.org>
	<42E9C245.6050205@m1k.net>
	<20050728225433.6dbfecbe.akpm@osdl.org>
	<42EAF885.40008@m1k.net>
	<20050729213724.01c61c26.akpm@osdl.org>
	<20050730023453.196a7477.frank.peters@comcast.net>
	<20050731184532.GA9026@ucw.cz>
	<20050731152406.200fe1c1.frank.peters@comcast.net>
	<20050731134245.742b9fc2.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2005 13:42:45 -0700
Andrew Morton <akpm@osdl.org> wrote:

> > 
> > Booting linux-2.6.13-rc4 with the "usb-handoff" option gives me
> > a working keyboard everytime now.
> 
> But 2.6.12 did not require this workaround, yes?
> 

I still have linux-2.6.12.3 on my machine and the "usb-handoff"
option fixes things for that version also.  Linux-2.6.12.3 does
need this option with my hardware.

Frank Peters

