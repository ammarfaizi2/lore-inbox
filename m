Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbVG2Fzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVG2Fzm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 01:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262387AbVG2Fzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 01:55:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5798 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262385AbVG2Fzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 01:55:39 -0400
Date: Thu, 28 Jul 2005 22:54:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: mkrufky@m1k.net
Cc: frank.peters@comcast.net, vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
Message-Id: <20050728225433.6dbfecbe.akpm@osdl.org>
In-Reply-To: <42E9C245.6050205@m1k.net>
References: <20050624113404.198d254c.frank.peters@comcast.net>
	<42BC306A.1030904@m1k.net>
	<20050624125957.238204a4.frank.peters@comcast.net>
	<42BC3EFE.5090302@m1k.net>
	<20050728222838.64517cc9.akpm@osdl.org>
	<42E9C245.6050205@m1k.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky <mkrufky@m1k.net> wrote:
>
>  Sadly, I must report that yes, the problem still intermittently occurs 
>  in 2.6.13-rc4 :-(  I'm the one that tested on the Shuttle FT61 
>  Motherboard.  Never has a problem in windows and never in 2.6.11 and 
>  earlier.
> 
>  I first noticed this problem sometime during 2.6.12-rc series.

Sigh.  I think it would help if you could generate a new report, please.

We need a super-easy way for people to do bisection searching.
