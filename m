Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbUK3Vym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbUK3Vym (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbUK3Vym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 16:54:42 -0500
Received: from gprs214-130.eurotel.cz ([160.218.214.130]:20097 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262340AbUK3Vyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 16:54:39 -0500
Date: Tue, 30 Nov 2004 22:54:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Avi Kivity <avi@argo.co.il>
Cc: Miklos Szeredi <miklos@szeredi.hu>, alan@lxorguk.ukuu.org.uk,
       torvalds@osdl.org, hbryan@us.ibm.com, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041130215422.GD1361@elf.ucw.cz>
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com> <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <41A47B67.6070108@argo.co.il> <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu> <41ACBF87.4040206@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ACBF87.4040206@argo.co.il>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Of course, implementing this is probably not trivial.  But I don't see
> >it as a theoretical problem as Linus does. 
>
> I don't see a theoretical problem, just some practical ones.
> 
> All can be overcome IMO, and it would be well worth it, too.

Well, coda does overcome this one, so it is possible :-).

Of course, coda works on whole files, which has other
implications. Yes, I'd very much like to see this solved. I was
developing/using uservfs for quite long and it is very nice for the
user.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
