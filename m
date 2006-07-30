Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWG3AhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWG3AhP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 20:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWG3AhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 20:37:15 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:25022 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750894AbWG3AhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 20:37:13 -0400
Date: Sat, 29 Jul 2006 20:37:09 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, Venkat Yekkirala <vyekkirala@TrustedCS.com>,
       linux-kernel@vger.kernel.org, davem@davemloft.net,
       netdev@vger.kernel.org, sds@tycho.nsa.gov
Subject: Re: [-mm patch] security/selinux/hooks.c: make 4 functions static
In-Reply-To: <20060729174830.GD26963@stusta.de>
Message-ID: <Pine.LNX.4.64.0607292036460.31683@d.namei>
References: <20060727015639.9c89db57.akpm@osdl.org> <20060729174830.GD26963@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jul 2006, Adrian Bunk wrote:

> On Thu, Jul 27, 2006 at 01:56:39AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.18-rc2-mm1:
> >...
> >  git-net.patch
> >...
> >  git trees
> >...
> 
> This patch makes four needlessly global functions static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>


Acked-by: James Morris <jmorris@namei.org>




-- 
James Morris
<jmorris@namei.org>
