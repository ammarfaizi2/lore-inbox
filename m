Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbTE2TAF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 15:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTE2TAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 15:00:05 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:726 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262520AbTE2TAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 15:00:04 -0400
Date: Thu, 29 May 2003 16:11:12 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Georg Nikodym <georgn@somanetworks.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: -rc7   Re: Linux 2.4.21-rc6
In-Reply-To: <20030529140025.61f991d4.georgn@somanetworks.com>
Message-ID: <Pine.LNX.4.55L.0305291609580.14835@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>
 <20030529140025.61f991d4.georgn@somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 May 2003, Georg Nikodym wrote:

> On Wed, 28 May 2003 21:55:39 -0300 (BRT)
> Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
>
> > Here goes -rc6. I've decided to delay 2.4.21 a bit and try Andrew's
> > fix for the IO stalls/deadlocks.
>
> While others may be dubious about the efficacy of this patch, I've been
> running -rc6 on my laptop now since sometime last night and have seen
> nothing odd.
>
> In case anybody cares, I'm using both ide and a ieee1394 (for a large
> external drive [which implies scsi]) and I do a _lot_ of big work with
> BK so I was seeing the problem within hours previously.

Great!

-rc7 will have to be released due to some problems :(
