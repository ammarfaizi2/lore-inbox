Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVBAXX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVBAXX3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVBAXX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:23:28 -0500
Received: from waste.org ([216.27.176.166]:51948 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262173AbVBAXXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:23:20 -0500
Date: Tue, 1 Feb 2005 15:22:45 -0800
From: Matt Mackall <mpm@selenic.com>
To: Lorenzo Hern?ndez Garc?a-Hierro <lorenzo@gnu.org>
Cc: Valdis.Kletnieks@vt.edu, Adrian Bunk <bunk@stusta.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, netdev@oss.sgi.com,
       Hank Leininger <hlein@progressive-comp.com>
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
Message-ID: <20050201232245.GB17460@waste.org>
References: <1106932637.3778.92.camel@localhost.localdomain> <20050128100229.5c0e4ea1@dxpl.pdx.osdl.net> <1106937110.3864.5.camel@localhost.localdomain> <20050128105217.1dc5ef42@dxpl.pdx.osdl.net> <1106944492.3864.30.camel@localhost.localdomain> <1106945266.7776.41.camel@laptopd505.fenrus.org> <200501290915.j0T9FkVY012948@turing-police.cc.vt.edu> <20050131165025.GN18316@stusta.de> <200501311942.j0VJgIYs016952@turing-police.cc.vt.edu> <1107201800.3754.125.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107201800.3754.125.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 09:03:19PM +0100, Lorenzo Hern?ndez Garc?a-Hierro wrote:
> Arjan, I will give it a further look, is there anything you want to
> comment about it before I start?
> 
> I will re-code it to put the helper functions in random.c.

Do it against -mm, please, there are something like 30 patches against
random.c there already. And please cc: me on any changes there.

-- 
Mathematics is the supreme nostalgia of our time.
