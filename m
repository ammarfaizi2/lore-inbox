Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbTHZSic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 14:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbTHZSic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 14:38:32 -0400
Received: from angband.namesys.com ([212.16.7.85]:21380 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S261683AbTHZSib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 14:38:31 -0400
Date: Tue, 26 Aug 2003 22:38:30 +0400
From: Oleg Drokin <green@namesys.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: reiser4 snapshot for August 26th.
Message-ID: <20030826183830.GD25037@namesys.com>
References: <20030826102233.GA14647@namesys.com> <1061922037.1670.3.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061922037.1670.3.camel@spc9.esa.lanl.gov>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Aug 26, 2003 at 12:20:38PM -0600, Steven Cole wrote:
> >    I have just released another reiser4 snapshot that I hope all interested
> >    parties will try. It is released against 2.6.0-test4.
> >    You can find it at http://namesys.com/snapshots/2003.08.26
> >    I include release notes below.
> > Reiser4 snapshot for 2003.08.26
> I got this error while attempting to compile with reiser4.
> Snippet from .config follows.
> [steven@spc1 linux-2.6.0-test4-r4]$ grep REISER4 .config
> CONFIG_REISER4_FS=y
> CONFIG_REISER4_FS_SYSCALL=y

Do not compile sys reiser4 support. It is not yet ready.
(hm, probably I need to hide that option for next snapshot)


Bye,
    Oleg
