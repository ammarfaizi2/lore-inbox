Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVCNT37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVCNT37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 14:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVCNT36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 14:29:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41365 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261751AbVCNT34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:29:56 -0500
Date: Mon, 14 Mar 2005 14:29:43 -0500
From: Alan Cox <alan@redhat.com>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Alan Cox <alan@redhat.com>, Linux kernel <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [patch] x86: fix ESP corruption CPU bug (take 2)
Message-ID: <20050314192943.GG18826@devserv.devel.redhat.com>
References: <42348474.7040808@aknet.ru> <20050313201020.GB8231@elf.ucw.cz> <4234A8DD.9080305@aknet.ru> <Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org> <4234B96C.9080901@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4234B96C.9080901@aknet.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 01:06:36AM +0300, Stas Sergeev wrote:
> Alan, can you please apply that to an -ac
> tree?

Ask Andrew Morton as it belongs in the -mm tree
