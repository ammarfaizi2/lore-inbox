Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVECN6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVECN6Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 09:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVECN6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 09:58:23 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:47832 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261551AbVECN6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 09:58:18 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [2.6 patch] Kconfig: rename "---help---" to "help" in Kconfig  files (first part)
To: Roman Zippel <zippel@linux-m68k.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Jesper Juhl <juhl-lkml@dif.dk>
Reply-To: 7eggert@gmx.de
Date: Tue, 03 May 2005 15:56:38 +0200
References: <3ZTLT-3D3-1@gated-at.bofh.it> <401Js-1AH-1@gated-at.bofh.it> <401Tf-1Hp-9@gated-at.bofh.it> <402FB-2mN-15@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DSxtF-0001Dz-N6@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
> On Tue, 3 May 2005, Adrian Bunk wrote:

>> IMHO, Kconfig files are quite readable due to this indentation even
>> though only a minority of the entries was using "---help---" even
>> before this patch.
> 
> So why exactly has to be removed? Is it ugly?

IMO yes, it's less readable for me than "help". ¢¢
-- 
Fun things to slip into your budget
TRUE:  $3000 for light bulb rotation

