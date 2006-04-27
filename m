Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWD0UQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWD0UQp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWD0UQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:16:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12982 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030209AbWD0UQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:16:44 -0400
Subject: Re: [-mm patch] fix VIDEO_DEV=m, VIDEO_V4L1_COMPAT=y
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       v4l-dvb-maintainer@linuxtv.org
In-Reply-To: <20060427111718.570d5650.akpm@osdl.org>
References: <20060427014141.06b88072.akpm@osdl.org>
	 <20060427175727.GH3570@stusta.de>  <20060427111718.570d5650.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 27 Apr 2006 17:15:15 -0300
Message-Id: <1146168915.3692.54.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian,

Em Qui, 2006-04-27 às 11:17 -0700, Andrew Morton escreveu:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > Below is the patch I sent you after I discovered the bug 
> >  in 2.6.17-rc1-mm3. Is there any reason why you didn't merge my patch?
> 
> I saw you'd cc'ed the maintainer on it.
I didn't received the patch you sent before. I'm applying it to my tree.

I will update today also devel, so that akpm may retrieve this one (and
also a bunch of newer patches...). Let me first test the hole patchset
with allyesconfig/allmodconfig to avoid other troubles.


Cheers, 
Mauro.

