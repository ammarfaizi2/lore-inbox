Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265576AbTGIBFd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 21:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267783AbTGIBFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 21:05:33 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:49801 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S265576AbTGIBFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 21:05:32 -0400
Date: Wed, 9 Jul 2003 03:20:14 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.74] devfs lookup deadlock/stack corruption combined patch
Message-ID: <20030709012014.GA19777@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Andrey Borzenkov <arvidjaar@mail.ru>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <E198K0q-000Am8-00.arvidjaar-mail-ru@f23.mail.ru> <200307072306.15995.arvidjaar@mail.ru> <20030707140010.4268159f.akpm@osdl.org> <200307082149.17918.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200307082149.17918.arvidjaar@mail.ru>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 09:49:17PM +0400, Andrey Borzenkov wrote:
> 
> I do not want to sound like it has to be ignored - but devfs code is so messy 
> that no trivial fix exists that would not make code even more messy. So I 

sorry to interrupt, but wasn't there an ongoing
efford to replace the devfs with smalldevfs or 
something even better? *hint*

please ignore me, if I'm talking nonsense ...

best,
Herbert

> would still apply original fixes and let this problem be solved later - it is 
> not so important as to delay two other.
> 
> -andrey
