Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270932AbTGPQRf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270938AbTGPQRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:17:35 -0400
Received: from [66.212.224.118] ([66.212.224.118]:8453 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270932AbTGPQRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:17:34 -0400
Date: Wed, 16 Jul 2003 12:21:03 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: "David S. Miller" <davem@redhat.com>
Cc: Ben Collins <bcollins@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] fix warning in iee1394 nodemgr
In-Reply-To: <20030716074637.253ee2fc.davem@redhat.com>
Message-ID: <Pine.LNX.4.53.0307161217230.32541@montezuma.mastecende.com>
References: <Pine.LNX.4.53.0307160159330.32541@montezuma.mastecende.com>
 <20030716141008.GE685@phunnypharm.org> <20030716074637.253ee2fc.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jul 2003, David S. Miller wrote:

> On Wed, 16 Jul 2003 10:10:08 -0400
> Ben Collins <bcollins@debian.org> wrote:
> 
> > I'm a little concerned that I've never seen either of the two warnings
> > you showed. I've been building with -Werror for awhile now.
> 
> GCC generates slightly different flow graphs on different
> platforms, and from version to version gcc's "might be used
> uninitialized" accuracy varies :-)

Come to think of it, i just switched back to RH 2.96 for my test kernels 
(just for compile speed, slow build box).

-- 
function.linuxpower.ca
