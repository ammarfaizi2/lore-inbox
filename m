Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbUDLTpc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 15:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUDLTpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 15:45:32 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:33166 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262962AbUDLTpa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 15:45:30 -0400
Date: Mon, 12 Apr 2004 21:52:08 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Marcus Hartig <m.f.h@web.de>
Subject: Re: 2.6.5-mm4
Message-ID: <20040412195208.GA12665@mars.ravnborg.org>
Mail-Followup-To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
	linux-kernel@vger.kernel.org, Marcus Hartig <m.f.h@web.de>
References: <407AEBB0.1050305@web.de> <200404122135.57622@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404122135.57622@WOLK>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 09:35:57PM +0200, Marc-Christian Petersen wrote:
> On Monday 12 April 2004 21:19, Marcus Hartig wrote:
> 
> Hi Marcus,
> 
> > patch: "kbuild-external-module-support" ?
> 
> actually, this one: "move-__this_module-to-modpost.patch" started breaking 
> nvidia, but strangely not for all people. For me it worked fine (prior to 
> 2.6.5-mm4), but other people got "invalid module format" after compiling 
> nvidia driver and tried to load it. P.S.: kbuild-external-module-support 
> breaks VMware too :p
Could I please get more info. I do not plan to install wmware right now,
so at least some minimal information allowing me to realise why it no
longer works.
Please with pointers to the used WMWare version so I can check their
Makefile etc.

	Sam
