Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbVKEHX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbVKEHX6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 02:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVKEHX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 02:23:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46768 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751314AbVKEHX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 02:23:57 -0500
Date: Fri, 4 Nov 2005 23:20:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: calin@ajvar.org, ajoshi@shell.unixbox.com, linux-kernel@vger.kernel.org,
       linux-nvidia@lists.surfsouth.com, torvalds@osdl.org
Subject: Re: [PATCH] nvidiafb: Geforce 7800 series support added
Message-Id: <20051104232035.78f6bb2a.akpm@osdl.org>
In-Reply-To: <436C5868.3090809@gmail.com>
References: <Pine.LNX.4.64.0511042031470.9781@rtlab.med.cornell.edu>
	<436C2DCE.1030509@pol.net>
	<20051104200913.701e0f62.akpm@osdl.org>
	<436C5868.3090809@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonino A. Daplas" <adaplas@gmail.com> wrote:
>
> Andrew Morton wrote:
> >> If nobody takes your patch, I'll pick it up.
> >>
> > 
> > Is OK, I'm slowly working my way towards it.
> 
> Thanks. BTW, when's 2.6.14-mm1 coming?

gack.  Nearly finished merging the 300-400 patch backlog.  Then I need to
resync with everyone's trees (shudder).  Then I need to fix all the compile
errors (which seem to run at about one-in-ten).  Then I need to get it to
limp to a login prompt on a few machines.

Sunday, if all goes as usual?
