Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263294AbUJ2Mtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263294AbUJ2Mtf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 08:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbUJ2Mtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 08:49:32 -0400
Received: from mail.dif.dk ([193.138.115.101]:65260 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S263294AbUJ2Mt3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 08:49:29 -0400
Date: Fri, 29 Oct 2004 14:45:49 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, dan@fullmotions.com,
       linux-kernel@vger.kernel.org
Subject: Re: SSH and 2.6.9
In-Reply-To: <2a4f155d04102903551f558132@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0410291443110.22050@jjulnx.backbone.dif.dk>
References: <1098906712.2972.7.camel@hanzo.fullmotions.com> 
 <Pine.LNX.4.61.0410272247460.3284@dragon.hygekrogen.localhost> 
 <1098912301.4535.1.camel@hanzo.fullmotions.com>  <1098913797.3495.0.camel@hanzo.fullmotions.com>
  <Pine.LNX.4.61.0410280034020.3284@dragon.hygekrogen.localhost> 
 <20041028022942.7ef1a8b8.akpm@osdl.org>  <Pine.LNX.4.61.0410291234530.22050@jjulnx.backbone.dif.dk>
 <2a4f155d04102903551f558132@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004, ismail dönmez wrote:

> Date: Fri, 29 Oct 2004 13:55:33 +0300
> From: ismail dönmez <ismail.donmez@gmail.com>
> To: Jesper Juhl <juhl-lkml@dif.dk>
> Cc: Andrew Morton <akpm@osdl.org>, dan@fullmotions.com,
>     linux-kernel@vger.kernel.org
> Subject: Re: SSH and 2.6.9
> 
> Slackware 10 is (was?) known to have a faulty udev.rules files
> breaking /dev/tty with latest 2.6 kernels. I already reported this to
> Patrick Volkerding but have no idea if its fixed because I am now a
> Debian user *g*.
> 
That sounds plausible, since I'm running Slackware myself, but I'm running 
slackware-current, and one of the things currently in -current is an udev 
update. That would explain why I don't see the problem while Danny does.

--
Jesper Juhl 

