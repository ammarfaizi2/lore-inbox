Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbTITTYz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 15:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbTITTYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 15:24:55 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:40832 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261357AbTITTYy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 15:24:54 -0400
Date: Sat, 20 Sep 2003 20:24:37 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>, pfg@sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Altix console driver
Message-ID: <20030920192437.GA8953@mail.jlokier.co.uk>
References: <20030917222414.GA25931@sgi.com> <20030917152139.42a1ce20.akpm@osdl.org> <1063886970.15957.13.camel@dhcp23.swansea.linux.org.uk> <20030919152118.GA2121@sgi.com> <1063985618.18723.19.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063985618.18723.19.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2003-09-19 at 16:21, Jesse Barnes wrote:
> > Well, according to the FSF our extra clauses are compatible with the GPL
> > and LGPL.  See http://oss.sgi.com/projects/GenInfo/NoticeExplan/.  If
> > you still disagree then we'll have to try to find another solution.
> 
> I think I need to discuss this with Eben, it certainly seems a problem
> to me but he's the legal expert so I want to find out his view first.

My reading of the boilerplate is that I can't use their code in
another GPL program, because their patent grant doesn't extend to
other programs.

Even if that's permitted by the GPL, it doesn't mean you have to
accept it into the kernel like that.

If that's just a misunderstanding of the legalese on my part, then
IMHO the text needs to be clarified to ensure that everyone knows they
may take the code and use it in other GPL projects.

-- Jamie
