Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264141AbUA3WS6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 17:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUA3WS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 17:18:58 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:16915 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264141AbUA3WS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 17:18:56 -0500
Date: Sat, 31 Jan 2004 09:18:28 +1100
From: Nathan Scott <nathans@sgi.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Xose Vazquez Perez <xose@wanadoo.es>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Compile Regression] 2.4.25-pre8: 126 warnings 0 errors
Message-ID: <20040131091828.A3584036@wobbly.melbourne.sgi.com>
References: <401A9F2B.1060400@wanadoo.es> <Pine.LNX.4.58L.0401301700420.2675@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58L.0401301700420.2675@logos.cnet>; from marcelo.tosatti@cyclades.com on Fri, Jan 30, 2004 at 05:11:20PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 05:11:20PM -0200, Marcelo Tosatti wrote:
> 
> This is a shame. These warnings piled up during time.
> 
> It is very likely that all of them are harmless,
> but they need to be fixed.
> 
> Will find to look into some of them. Help is appreciated.
> 
> >    fs/xfs: 1 warnings, 0 errors

I have a fix for this one in a bk tree with a couple of other
pending XFS fixups - I'll send it along soon.  The warning is
completely benign.

cheers.

-- 
Nathan
