Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbTIOGrT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 02:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbTIOGrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 02:47:18 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:46726 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S262441AbTIOGrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 02:47:17 -0400
From: Michael Neuffer <neuffer@neuffer.info>
Date: Mon, 15 Sep 2003 08:46:23 +0200
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [1/4] [2.6 patch] better i386 CPU selection
Message-ID: <20030915064623.GA6772@neuffer.info>
References: <20030913222443.GN27368@fs.tum.de> <20030913222659.GO27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913222659.GO27368@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adrian Bunk (bunk@fs.tum.de):
> [...]
> - help text changes/updates
> [...]  
> -config M686
> +config CPU_686
>  	bool "Pentium-Pro"
>  	help
> -	  Select this for Intel Pentium Pro chips.  This enables the use of
> -	  Pentium Pro extended instructions, and disables the init-time guard
> -	  against the f00f bug found in earlier Pentiums.
> +	  Select this for Intel Pentium Pro chips.
> [...one example left]  


Hi Adrian


Is there a valid reason why you removed most of the
descriptions ? I think a bit of a background on the
CPU selections is helpful and interesting, especially 
for newcommers. You've cut it down so far, that you 
could also put there "Read Variable Name" or 
"No help available"  instead.

Cheers
   Mike 
