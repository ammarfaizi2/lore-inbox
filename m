Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbTDKFhS (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 01:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbTDKFhS (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 01:37:18 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:52748 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264254AbTDKFhR (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 01:37:17 -0400
Date: Fri, 11 Apr 2003 02:49:32 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: DevilKin <devilkin-lkml@blindguardian.org>
Cc: Jon Portnoy <portnoy@tellink.net>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel support for non-english user messages
Message-ID: <20030411054932.GC10992@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	DevilKin <devilkin-lkml@blindguardian.org>,
	Jon Portnoy <portnoy@tellink.net>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3E93A958.80107@si.rr.com> <Pine.LNX.4.53.0304101638010.4978@chaos> <Pine.LNX.4.53.0304101903280.19136@cerberus.oppresses.us> <200304110739.41947.devilkin-lkml@blindguardian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304110739.41947.devilkin-lkml@blindguardian.org>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 11, 2003 at 07:39:35AM +0200, DevilKin escreveu:
> Why not turn it into a kernel flag that you can set at bootup through LILO or 
> some other obscure boot manager? Then you could boot linux like this:
> 
> linux dmesg=verbose
> 
> and
> 
> linux dmesg=quiet

Have you ever tried passing 'quiet' as a cmd line parameter to the kernel
in the bootloader? If not please try.

Try also 'debug'.

- Arnaldo
