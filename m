Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbUFSSji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUFSSji (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 14:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbUFSSji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 14:39:38 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:55818 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262175AbUFSSjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 14:39:37 -0400
Date: Sat, 19 Jun 2004 20:34:02 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] save kernel version in .config file
Message-ID: <20040619183402.GA1458@alpha.home.local>
References: <20040617220651.0ceafa91.rddunlap@osdl.org> <20040618053455.GF29808@alpha.home.local> <20040618205602.GC4441@mars.ravnborg.org> <20040618150535.6a421bdb.rddunlap@osdl.org> <20040619040717.GA32209@alpha.home.local> <20040618220253.6a7577f4.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618220253.6a7577f4.rddunlap@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 10:02:53PM -0700, Randy.Dunlap wrote:
> | PS: do you think this could be done easily to 2.4 too ?
> 
> It's trivial for 'make menuconfig' (bash scripting) [below].

Cool, thank you very much Randy.

> OTOH, I won't look at the tcl/tk 'xconfig' stuff...

Not my problem either, I haven't used it for 3 or 4 years.

Cheers,
Willy

