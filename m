Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbTAIHlt>; Thu, 9 Jan 2003 02:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbTAIHlt>; Thu, 9 Jan 2003 02:41:49 -0500
Received: from havoc.daloft.com ([64.213.145.173]:1227 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261854AbTAIHlt>;
	Thu, 9 Jan 2003 02:41:49 -0500
Date: Thu, 9 Jan 2003 02:50:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Richard Stallman <rms@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gauntlet Set NOW!
Message-ID: <20030109075026.GA26580@gtf.org>
References: <Pine.LNX.4.10.10301031425590.421-100000@master.linux-ide.org> <E18WX7P-0001cV-00@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E18WX7P-0001cV-00@fencepost.gnu.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 02:28:47AM -0500, Richard Stallman wrote:
> That's not the FSF's view.  Our view is that just using structure
> definitions, typedefs, enumeration constants, macros with simple
> bodies, etc., is NOT enough to make a derivative work.  It would take
> a substantial amount of code (coming from inline functions or macros
> with substantial bodies) to do that.

Richard,

Thanks much for posting this.  I admit I have been skipping this entire
thread pretty much :) but the above is worth highlighting.

Unfortunately, while helpful, this doesn't necessarily solve the problem
in Linux; the things that are inlined are quite often fairly "smart"
pieces of code and not just things as simple as wrapper functions, or
structures and typedefs.

Regardless, thanks again to posting the above.

Regards,

	Jeff


