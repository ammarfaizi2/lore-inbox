Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbUD3VHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUD3VHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 17:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUD3VHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 17:07:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:12197 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261186AbUD3VGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 17:06:50 -0400
Date: Fri, 30 Apr 2004 14:05:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Marc Boucher <marc@linuxant.com>
cc: "'Sean Estabrooks'" <seanlkml@rogers.com>,
       "'Paul Wagland'" <paul@wagland.net>, "'Rik van Riel'" <riel@redhat.com>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "'Peter Williams'" <peterw@aurema.com>, Hua Zhong <hzhong@cisco.com>,
       "'Timothy Miller'" <miller@techsource.com>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       koke@sindominio.net, "'Rusty Russell'" <rusty@rustcorp.com.au>,
       "'David Gibson'" <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <6238ED6D-9AE8-11D8-B83D-000A95BCAC26@linuxant.com>
Message-ID: <Pine.LNX.4.58.0404301401420.18014@ppc970.osdl.org>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com>
 <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org>
 <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com>
 <Pine.LNX.4.58.0404301319020.18014@ppc970.osdl.org>
 <69A8B470-9AE6-11D8-B83D-000A95BCAC26@linuxant.com>
 <Pine.LNX.4.58.0404301343140.18014@ppc970.osdl.org>
 <6238ED6D-9AE8-11D8-B83D-000A95BCAC26@linuxant.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Apr 2004, Marc Boucher wrote:
> 
> are you claiming that anything that uses the MODULE_LICENSE() macro 
> becomes a derived work of the Linux kernel subject to the GPL?

I'm claiming that you are wilfully misrepresenting the license of your 
code to another piece of code THAT YOU DON'T CONTROL.

I'm further claiming that this is unethical and quite possibly illegal.

How hard is that to understand? Remove that stupid lying line. Pronto.

How the _hell_ can you stand up for lying in public? Have you no shame?

		Linus
