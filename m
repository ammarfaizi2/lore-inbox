Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWGLXVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWGLXVH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWGLXVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:21:07 -0400
Received: from terminus.zytor.com ([192.83.249.54]:43959 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751424AbWGLXVG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:21:06 -0400
Message-ID: <44B58396.7080703@zytor.com>
Date: Wed, 12 Jul 2006 16:19:50 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Jakub Jelinek <jakub@redhat.com>, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
References: <20060712184412.2BD57180061@magilla.sf.frob.com>	 <44B54EA4.5060506@redhat.com> <20060712195349.GW3823@sunsite.mff.cuni.cz>	 <44B556E5.5000702@zytor.com> <m1k66i8ql5.fsf@ebiederm.dsl.xmission.com>	 <1152739766.3217.83.camel@laptopd505.fenrus.org>	 <m1bqru8p36.fsf@ebiederm.dsl.xmission.com>	 <1152741665.3217.85.camel@laptopd505.fenrus.org>	 <44B57191.5000802@zytor.com>  <m1zmfe794e.fsf@ebiederm.dsl.xmission.com> <1152745664.22943.115.camel@localhost.localdomain>
In-Reply-To: <1152745664.22943.115.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> [Disclaimer: There is a patent issue around this technique but its not
> one that will impact GPL code as permissions are given for GPL use.]
> 

glibc is (and has to be) LGPL.

Anyway, it seems absolutely insane that having a programmable threshold 
for spinning is patented...

	-hpa
