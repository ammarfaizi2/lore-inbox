Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263347AbTC0Rrz>; Thu, 27 Mar 2003 12:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263356AbTC0Rrz>; Thu, 27 Mar 2003 12:47:55 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:33032 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263347AbTC0Rry>;
	Thu, 27 Mar 2003 12:47:54 -0500
Date: Thu, 27 Mar 2003 09:58:06 -0800
From: Greg KH <greg@kroah.com>
To: Patrick McHardy <kaber@trash.net>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       Chris Sykes <chris@sigsegv.plus.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at sched.c:564! (2.4.20, 2.4.21-pre5-ac3)
Message-ID: <20030327175806.GE32667@kroah.com>
References: <20030326162538.GG2695@spackhandychoptubes.co.uk> <20030326185236.GE24689@kroah.com> <20030326192520.GH2695@spackhandychoptubes.co.uk> <20030326193437.GI24689@kroah.com> <20030327111600.GI2695@spackhandychoptubes.co.uk> <20030327131214.1dae4005.skraw@ithnet.com> <3E82F00F.7@trash.net> <20030327174503.GB32667@kroah.com> <3E833A24.8060606@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E833A24.8060606@trash.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 06:51:32PM +0100, Patrick McHardy wrote:
> 
> this patch is for 2.4, isdn_get_free_channel is protected by cli() 
> everywhere.

Ah, sorry, I thought we were talking about 2.5 here (well the thread had
moved that way, even if the subject: had not :)

greg k-h
