Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262599AbTCZWbe>; Wed, 26 Mar 2003 17:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262603AbTCZWbe>; Wed, 26 Mar 2003 17:31:34 -0500
Received: from home.wiggy.net ([213.84.101.140]:34712 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S262599AbTCZWbd>;
	Wed, 26 Mar 2003 17:31:33 -0500
Date: Wed, 26 Mar 2003 23:42:45 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [FIX] Re: 2.5.66 new fbcon oops while loading X
Message-ID: <20030326224245.GN2078@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030326145412.GI2078@wiggy.net> <Pine.LNX.4.44.0303262009560.21188-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303262009560.21188-100000@phoenix.infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously James Simmons wrote:
> That is no longer true. The fb nodes should be recreated. I fixed the docs 
> in devices.txt

Fine with me, however someone might want to look at the device numbering
that the various Linux distros are using at this moment. I know Debian
is using the old numbering and I just filed a bugreport to get that
updated. I do expect a fair amount of people will run into this when
they upgrade to 2.5/2.6 kernels.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
