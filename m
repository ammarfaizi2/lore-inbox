Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264026AbTDWNKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 09:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbTDWNKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 09:10:31 -0400
Received: from [81.80.245.157] ([81.80.245.157]:16040 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id S264026AbTDWNKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 09:10:30 -0400
Date: Wed, 23 Apr 2003 15:22:27 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Ben Collins <bcollins@debian.org>
Cc: Tony Spinillo <tspinillo@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030423132227.GI820@hottah.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Ben Collins <bcollins@debian.org>,
	Tony Spinillo <tspinillo@yahoo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030423122940.51011.qmail@web14002.mail.yahoo.com> <20030423125315.GH820@hottah.alcove-fr> <20030423130139.GD354@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423130139.GD354@phunnypharm.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 09:01:39AM -0400, Ben Collins wrote:

> > I'll leave up to the ieee1394 developpers to decide if some other,
> > semaphore based, locking is still necessary here.
> 
> The patch is broken, and the problem is already fixed in our repo. Just
> a matter of getting Marcelo to accept my patch before 2.4.21 is
> released.

Can we see it please ?

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
