Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVARLqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVARLqg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 06:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVARLqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 06:46:36 -0500
Received: from colin2.muc.de ([193.149.48.15]:31763 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261260AbVARLqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 06:46:33 -0500
Date: 18 Jan 2005 12:46:32 +0100
Date: Tue, 18 Jan 2005 12:46:32 +0100
From: Andi Kleen <ak@muc.de>
To: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       lkst-develop@lists.sourceforge.net
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050118114632.GN43344@muc.de>
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de> <41ECF0B6.30106@sdl.hitachi.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ECF0B6.30106@sdl.hitachi.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 08:19:18PM +0900, Masami Hiramatsu wrote:
> Hello,
> 
> I?m a developer of yet another kernel tracer, LKST. I and co-developers 
> are very glad to hear that LTT was merged into -mm tree and to talk 
> about the kernel tracer on this ML. Because we think that the kernel 
> event tracer is useful to debug Linux systems, and to improve the kernel 
> reliability.

I haven't looked at your code, but I would suggest you also post
for review it so that it can be evaluated in the same way
as other more noisy proposals.

Perhaps Andrew can test both for some time in MM like he used
to do for the various schedulers.

-Andi
