Return-Path: <linux-kernel-owner+w=401wt.eu-S1422741AbXAMRyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422741AbXAMRyp (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 12:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422740AbXAMRyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 12:54:45 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:33881 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422737AbXAMRyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 12:54:44 -0500
Date: Sat, 13 Jan 2007 12:54:43 -0500
To: Valdis.Kletnieks@vt.edu
Cc: Sunil Naidu <akula2.shark@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Choosing a HyperThreading/SMP/MultiCore kernel ?
Message-ID: <20070113175443.GX17267@csclub.uwaterloo.ca>
References: <8355959a0701120525m5d1a7904i56b8a8f7316883d6@mail.gmail.com> <20070112150349.GI17269@csclub.uwaterloo.ca> <200701130338.l0D3chOs026407@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701130338.l0D3chOs026407@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 10:38:43PM -0500, Valdis.Kletnieks@vt.edu wrote:
> amd64 will only work on a core2duo if it's a T7200 or higher - the
> lower numbers are 32-bit-only chipsets.  I admit not knowing what
> exact variant the Mac has.

The Core Duo had 32bit only (being a Pentium M), but the Core 2 Duo
should always be 64bit capable (at least that is what this list says:
http://en.wikipedia.org/wiki/List_of_Intel_Core_2_microprocessors#Core_2_Duo_2
)

> CONFIG_MCORE2=y

Oh good.  Makes life much simpler for users.

--
Len Sorensen
