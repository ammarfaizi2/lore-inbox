Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314389AbSFBVVY>; Sun, 2 Jun 2002 17:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSFBVVX>; Sun, 2 Jun 2002 17:21:23 -0400
Received: from mail.zmailer.org ([62.240.94.4]:26567 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S314389AbSFBVVW>;
	Sun, 2 Jun 2002 17:21:22 -0400
Date: Mon, 3 Jun 2002 00:21:22 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMB filesystem
Message-ID: <20020603002122.P18899@mea-ext.zmailer.org>
In-Reply-To: <3CFA875D.1050300@linkvest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2002 at 11:00:13PM +0200, Jean-Eric Cuendet wrote:
...
> Then, it can't be kernel only. I need a userspace daemon with which the 
> kernel will communicate, since the shared lib can't be added to the kernel.
> How do you think is the best way of doing things?
> Making a minimal FS kernel driver that communicate with a complex 
> userspace daemon?

  Look at how  CODA,  and especially Intermezzo do it.

> Thanks for comments/ideas.
> -jec

/Matti Aarnio
