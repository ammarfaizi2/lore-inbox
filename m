Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267455AbTBIUx5>; Sun, 9 Feb 2003 15:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267456AbTBIUx5>; Sun, 9 Feb 2003 15:53:57 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:58027
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267455AbTBIUxz>; Sun, 9 Feb 2003 15:53:55 -0500
Subject: Re: 2.4.21-pre4 - two simple compile fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20030209165926.GA19461@linuxhacker.ru>
References: <20030208171838.GA2230@linuxhacker.ru>
	 <20030209165408.GA19368@linuxhacker.ru>
	 <20030209165926.GA19461@linuxhacker.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044828158.30767.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 09 Feb 2003 22:02:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-09 at 16:59, Oleg Drokin wrote:
> Hello!
> 
>   With this trivial patch below I am able to compile with support
>   for come Cadet radio card and NatSemi SCx200
> 

I sent Marcelo the cadet one already and its fine, the scx200 one looks right too
I'll check that in -ac 

