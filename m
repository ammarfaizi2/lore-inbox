Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268395AbTBSMs0>; Wed, 19 Feb 2003 07:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268399AbTBSMs0>; Wed, 19 Feb 2003 07:48:26 -0500
Received: from lgsx01.lg.ehu.es ([158.227.2.34]:4875 "EHLO lgsx01.lg.ehu.es")
	by vger.kernel.org with ESMTP id <S268395AbTBSMsZ>;
	Wed, 19 Feb 2003 07:48:25 -0500
Date: Tue, 18 Feb 2003 13:52:59 +0100
From: Luis Miguel Garcia <ktech@wanadoo.es>
To: linux-kernel@vger.kernel.org
Subject: Re: Bug in 2.5.62 kernel
Message-Id: <20030218135259.3c8a3009.ktech@wanadoo.es>
In-Reply-To: <3E5246A5.6020003@nyc.rr.com>
References: <20030217173210.626efa05.ktech@wanadoo.es>
	<3E5246A5.6020003@nyc.rr.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello:

Yes, it was missing module-init-tools. Now I have my kernel compiled but when I try to boot, I can only see 

Uncompressing Kernel... booting linux....

and then I cannot see nothing more but the HD is going up and down during half a minute, so I think something is happening but my screen is not updating.

What can I test in order to boot my system?

I'm behing a Sony Vaio N505-VE laptop.

Thanks.

On Tue, 18 Feb 2003 09:43:49 -0500
John Weber <weber@nyc.rr.com> wrote:

> Luis Miguel Garcia wrote:
> > it's about 2.5.62
> > 
> > I can do a make bzImage correctly
> > I can do a make modules correctly
> > 
> > but
> > 
> > when I do a make modules_install I get a lot of
> > depmod: Unresolved Symbols in /lib/modules/2.5.62/xxxx/xxxxx/xxxx.ko
> > 
> > What ca I do in order to see what's happening?
> 
> Do you have module-init-tools installed?  Kernels since 2.5.48 require
> differed module utilities.
> 
> 
> 
> 


=============================================================
Luis Miguel Garcia Mancebo
Ingenieria Tecnica en Informatica de Gestion
Universidad de Deusto / University of Deusto
Bilbao / Spain
------------------------------------------------------------
there's no place that I could be without you
there's no place that I could gleam without you
there's no place that I could dream without you
there's no place that I could be without you
honestly
=============================================================
