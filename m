Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUGXS0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUGXS0d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 14:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUGXS0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 14:26:33 -0400
Received: from d-zg10-254.net4u.hr ([217.14.210.254]:14464 "HELO
	eagle.earth.my") by vger.kernel.org with SMTP id S262006AbUGXS0c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 14:26:32 -0400
From: mnalis@voyager.hr
Date: Sat, 24 Jul 2004 20:26:27 +0200
To: Jeff Woods <Kazrak+kernel@cesmail.net>
Cc: Adrian Bunk <bunk@fs.tum.de>, Matija Nalis <mnalis-umsdos@voyager.hr>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] remove UMSDOS
Message-ID: <20040724182627.GA3767@eagle.earth.my>
References: <20040711112821.GC4701@fs.tum.de> <6.1.1.1.0.20040711120748.041c8e60@no.incoming.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.1.1.1.0.20040711120748.041c8e60@no.incoming.mail>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 12:17:32PM -0600, Jeff Woods wrote:
> At 7/11/2004 01:28 PM +0200, Adrian Bunk wrote:
> >UMSDOS in 2.6 is broken, and it seems no one needs it enough to bother 
> >fixing it.

Just to notify anybody interested that I have started working on fixing
UMSDOS support for 2.6 kernels (as there still seems to be some people
wanting it). 

Patch that enables UMSDOS to compile and insmod is available at 
http://linux.voyager.hr/umsdos/
It still doesn't work (triggers kernel BUG() after few write ops), 
but I'll post another announcements when I get it in working condition.


-- 
Opinions above are GNU-copylefted.
