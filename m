Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbUCXXVK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 18:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUCXXVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 18:21:10 -0500
Received: from mail.tpgi.com.au ([203.12.160.100]:18823 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S262193AbUCXXVG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:21:06 -0500
Subject: Re: [Swsusp-devel] lzf license
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Marc Lehmann <pcg@schmorp.de>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Cameron Patrick <cameron@patrick.wattle.id.au>,
       Michael Frank <mhf@linuxmail.org>, Pavel Machek <pavel@suse.cz>,
       Software Suspend - Mailing Lists 
	<swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040322182121.GA21521@schmorp.de>
References: <opr49atvpk4evsfm@smtp.pacific.net.th>
	 <20040322094053.GO16890@patrick.wattle.id.au>
	 <1079948988.5296.8.camel@laptop.fenrus.com>
	 <20040322182121.GA21521@schmorp.de>
Content-Type: text/plain
Message-Id: <1080166848.2628.3.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Thu, 25 Mar 2004 10:20:48 +1200
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'm not sure what the verdict is in the end. Do we need changes to the
license? If so, could you send me a patch, Marc?

Regards,

Nigel

On Tue, 2004-03-23 at 06:21, Marc Lehmann wrote:
> On Mon, Mar 22, 2004 at 10:49:48AM +0100, Arjan van de Ven <arjanv@redhat.com> wrote:
> > > The licence so described looks to me the same as LZF's licence.
> > 
> > however at least I would prefer the author to dual license it ANYWAY,
> > because compression stuff generally is riddled with patents; the author
> > GPL licensing it at least gives all users a license of the authors
> > patents (if any). 
> 
> I would like to avoid dual-licensing and instead change the existing
> license to suit any needs, if at all possible. (Note that relicensing
> should be possible, at least this was my original goal).
> 
> If patents are an issue, how about adding this:
> 
>    4. The author is unaware of any existing patents and disclaims any
>       patents, or other restrictions, on the LZF algorithm or this
>       implementation.
> 
> I would add this clause to both future lzf distributions as well as the
> file that is part of the lzf patch.
> 
> If there are unavoidable reasons why the GPL is required, then I'd bite
> the bullet and dual-license it, in the hope that further bugfixes or
> modifications will be contributed under both licenses.
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

