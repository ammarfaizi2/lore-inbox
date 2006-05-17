Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWEQWYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWEQWYi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWEQWYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:24:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60358 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750850AbWEQWYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:24:37 -0400
Date: Wed, 17 May 2006 15:23:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wright <chrisw@sous-sol.org>
cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH 00/22] -stable review
In-Reply-To: <20060517221312.227391000@sous-sol.org>
Message-ID: <Pine.LNX.4.64.0605171522050.10823@g5.osdl.org>
References: <20060517221312.227391000@sous-sol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 May 2006, Chris Wright wrote:
>
> This is the start of the stable review cycle for the 2.6.16.17 release.
> There are 22 patches in this series, all will be posted as a response to
> this one.

I notice that none of the patches have authorship information.

Has that always been true and I just never noticed before?

Could you make your review script add the proper "From:" to the top of the 
body of the email so that that is visible during review too?

		Linus
