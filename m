Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWCZN3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWCZN3z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 08:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWCZN3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 08:29:55 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:37136 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751011AbWCZN3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 08:29:55 -0500
Message-ID: <4426974D.8040309@argo.co.il>
Date: Sun, 26 Mar 2006 15:29:49 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Arjan van de Ven <arjan@infradead.org>, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <1143376008.3064.0.camel@laptopd505.fenrus.org> <F31089B5-0915-439D-B218-009384E2148F@mac.com>
In-Reply-To: <F31089B5-0915-439D-B218-009384E2148F@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Mar 2006 13:29:53.0149 (UTC) FILETIME=[5D625AD0:01C650D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
>
> Well I guess you could call it UABI, but that might also imply that 
> it's _userspace_ that defines the interface, instead of the kernel.  
> Since the headers themselves are rather tightly coupled with the 
> kernel, I think I'll stick with the KABI name for now (unless somebody 
> can come up with a better one, of course :-D).
>
How about __linux, or __linux_abi? There are ABIs for other components, 
and other OSes. Linux is the name of the project after all.

-- 
error compiling committee.c: too many arguments to function

