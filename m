Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbUKEWOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbUKEWOT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 17:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbUKEWOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 17:14:18 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:31040 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261233AbUKEWOK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 17:14:10 -0500
Date: Sat, 6 Nov 2004 00:15:28 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: Print preprocessor directives correctly.
Message-ID: <20041105231528.GC9604@mars.ravnborg.org>
Mail-Followup-To: Alexey Dobriyan <adobriyan@mail.ru>,
	sam@ravnborg.org, linux-kernel@vger.kernel.org
References: <E1CP8iH-000D2z-00.adobriyan-mail-ru@f30.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CP8iH-000D2z-00.adobriyan-mail-ru@f30.mail.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 03:09:21AM +0300, Alexey Dobriyan wrote:
> Against http://linux-sam.bkbits.net:8080/kbuild/
> 
> Print preprocessor directives (usually "#ifdef CONFIG_SOMETHING" and "#endif")
> in structs definitions correctly (-text, -html, sgmldocs, htmldocs, pdfdocs,
> mandocs).

Applied.
PS. You need to re-clone my tree for futher changes - but usually on top
of Linus' latest is fine.

	Sam
