Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbUD3VEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUD3VEM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 17:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUD3VEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 17:04:11 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:10920 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S261197AbUD3UxL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:53:11 -0400
In-Reply-To: <Pine.LNX.4.58.0404301343140.18014@ppc970.osdl.org>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com> <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org> <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com> <Pine.LNX.4.58.0404301319020.18014@ppc970.osdl.org> <69A8B470-9AE6-11D8-B83D-000A95BCAC26@linuxant.com> <Pine.LNX.4.58.0404301343140.18014@ppc970.osdl.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6238ED6D-9AE8-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: "'Sean Estabrooks'" <seanlkml@rogers.com>,
       "'Paul Wagland'" <paul@wagland.net>, "'Rik van Riel'" <riel@redhat.com>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "'Peter Williams'" <peterw@aurema.com>, Hua Zhong <hzhong@cisco.com>,
       "'Timothy Miller'" <miller@techsource.com>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       koke@sindominio.net, "'Rusty Russell'" <rusty@rustcorp.com.au>,
       "'David Gibson'" <david@gibson.dropbear.id.au>
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Fri, 30 Apr 2004 16:53:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Apr 30, 2004, at 4:44 PM, Linus Torvalds wrote:
>
> The Linux-centric parts are absolutely NOT stand-alone, and one big 
> part
> of that Linux-centric stuff is that magic line that says 
> MODULE_LICENSE().
>

are you claiming that anything that uses the MODULE_LICENSE() macro 
becomes a derived work of the Linux kernel subject to the GPL?

Marc

