Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUD3U7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUD3U7Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 16:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUD3U7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 16:59:15 -0400
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:21091
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S261205AbUD3Uqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:46:38 -0400
Date: Fri, 30 Apr 2004 16:46:39 -0400
From: Sean Estabrooks <seanlkml@rogers.com>
To: Marc Boucher <marc@linuxant.com>
Cc: torvalds@osdl.org, paul@wagland.net, riel@redhat.com,
       B.Zolnierkiewicz@elka.pw.edu.pl, peterw@aurema.com, hzhong@cisco.com,
       miller@techsource.com, linux-kernel@vger.kernel.org,
       koke@sindominio.net, rusty@rustcorp.com.au, david@gibson.dropbear.id.au
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-Id: <20040430164639.72dea851.seanlkml@rogers.com>
In-Reply-To: <69A8B470-9AE6-11D8-B83D-000A95BCAC26@linuxant.com>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com>
	<Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org>
	<90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com>
	<Pine.LNX.4.58.0404301319020.18014@ppc970.osdl.org>
	<69A8B470-9AE6-11D8-B83D-000A95BCAC26@linuxant.com>
Organization: 
X-Mailer: Sylpheed version 0.9.9-gtk2-20040229 (GTK+ 2.2.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.103.219.176] using ID <seanlkml@rogers.com> at Fri, 30 Apr 2004 16:46:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2004 16:39:01 -0400
Marc Boucher <marc@linuxant.com> wrote:

> To clarify this important point, driverloader is a standalone project, 
> and structured similarly to the HSF driver (all os-specific code is 
> open-source allowing it to be used with any kernel or even 
> theoretically any other x86 operating system).
> 
> Because only one logical module is loaded, and a single set of tainted 
> messages bearable, the \0 MODULE_LICENSE() workaround is unnecessary 
> and not used in driverloader.
> 

After 150+ messages not even one concept that's been mentioned has pierced
the fog of your self righteousness has it?   Please just try to respect
the people who bring you Linux.

Sean.
