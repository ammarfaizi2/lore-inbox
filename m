Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264882AbSJPMhY>; Wed, 16 Oct 2002 08:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264845AbSJPMhY>; Wed, 16 Oct 2002 08:37:24 -0400
Received: from traven9.uol.com.br ([200.221.4.35]:13698 "EHLO
	traven9.uol.com.br") by vger.kernel.org with ESMTP
	id <S264882AbSJPMhX>; Wed, 16 Oct 2002 08:37:23 -0400
Date: Wed, 16 Oct 2002 09:31:34 -0200
From: Andre Costa <brblueser@uol.com.br>
To: clemens@dwf.com
Cc: Linux kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: What kernels 2.4.x 2.5.x compile gcc3.2???
Message-Id: <20021016093134.12d8bd76.brblueser@uol.com.br>
In-Reply-To: <200210151849.g9FInbur002088@orion.dwf.com>
References: <200210151849.g9FInbur002088@orion.dwf.com>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4.19 compiled just fine with gcc 3.2 here -- still using RH 7.1,
though (however, AFAIK RH dropped that "use-my-tweaked-compiler" thing
and shipped vanilla gcc 3.2 with RH 8.0).

HTH,

Andre

On Tue, 15 Oct 2002 12:49:37 -0600
clemens@dwf.com wrote:

> The subject just about says it.
> What versions of 2.4.x and 2.5.x compile cleanly with
> the new gcc 3.2 that is included in most recent releases
> (in particular RH8.0)
> 
> The 2.4.18-14 kernel sources from RH have LOTS of patches,
> and they (well the modules) still dont compile with their
> own config file (sigh).
> 
> 
> -- 
>                                         Reg.Clemens
>                                         reg@dwf.com
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Andre Oliveira da Costa
