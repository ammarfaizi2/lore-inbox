Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUCCNwx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 08:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbUCCNwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 08:52:53 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:3210 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S262337AbUCCNvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 08:51:55 -0500
Date: Wed, 3 Mar 2004 14:51:53 +0100
From: David Weinehall <david@southpole.se>
To: Coywolf Qi Hunt <coywolf@greatcn.org>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.0.40] Fix comment error of prepare_binprm() in exec.c
Message-ID: <20040303135153.GW19111@khan.acc.umu.se>
Mail-Followup-To: Coywolf Qi Hunt <coywolf@greatcn.org>,
	Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <401417A3.7000206@lovecn.org> <20040125222914.GB20879@khan.acc.umu.se> <1075223456.5219.1.camel@midux> <40172C5E.3090201@lovecn.org> <20040128033755.GC16675@khan.acc.umu.se> <4045DFC1.2010904@greatcn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4045DFC1.2010904@greatcn.org>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 09:38:09PM +0800, Coywolf Qi Hunt wrote:
> David Weinehall wrote:
> 
> >My aim for 2.0.41 is to make it a cleanup-release; remove warnings, tidy
> >up a little source-code mess, kill dead code, fix typos etc.
> >
> >
> >Regards: David Weinehall
> 
> Hello, David
> 
> In the comment of prepare_binprm() in fs/exec.c, 512 bytes should be 128 
> bytes.

Thanks.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
