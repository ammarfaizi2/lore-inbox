Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbUBHWT4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 17:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264233AbUBHWT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 17:19:56 -0500
Received: from h196n1fls22o974.bredband.comhem.se ([213.64.79.196]:60554 "EHLO
	latitude.mynet.no-ip.org") by vger.kernel.org with ESMTP
	id S264229AbUBHWTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 17:19:55 -0500
X-Mailer: exmh version 2.6.3 04/02/2003 with nmh-1.0.4
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Murilo Pontes <murilo_pontes@yahoo.com.br>, linux-kernel@vger.kernel.org
Subject: Re: psmouse.c, throwing 3 bytes away 
In-Reply-To: Message from Vojtech Pavlik <vojtech@suse.cz> 
   of "Sun, 08 Feb 2004 22:59:35 +0100." <20040208215935.GA13280@ucw.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 08 Feb 2004 23:19:32 +0100
From: aeriksson@fastmail.fm
Message-Id: <20040208221933.92D0B3F1B@latitude.mynet.no-ip.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> > Problem still occurs :-(
> 
> I have good news - I've managed to reliably reproduce the bug on my
> machine and that means I now have a good chance to find and fix it.
> 

Another data point. I just tried switching to a non-preempt kernel as
was suggested by someone. The problem still occurs.

/A


