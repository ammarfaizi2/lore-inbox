Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVDJRqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVDJRqw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 13:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVDJRqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 13:46:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:63716 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261537AbVDJRqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 13:46:38 -0400
Date: Sun, 10 Apr 2005 19:46:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@engr.sgi.com>
Cc: cw@f00f.org, torvalds@osdl.org, davem@davemloft.net, andrea@suse.de,
       mbp@sourcefrog.net, linux-kernel@vger.kernel.org,
       dlang@digitalinsight.com
Subject: Re: Kernel SCM saga..
Message-ID: <20050410174623.GB18768@elte.hu>
References: <20050408083839.GC3957@opteron.random> <Pine.LNX.4.58.0504081647510.28951@ppc970.osdl.org> <20050409022701.GA14085@opteron.random> <Pine.LNX.4.58.0504082240460.28951@ppc970.osdl.org> <20050409155511.7432d5c7.davem@davemloft.net> <Pine.LNX.4.58.0504091611570.1267@ppc970.osdl.org> <20050410001435.GA23401@taniwha.stupidest.org> <20050409185636.0945abdf.pj@engr.sgi.com> <20050410120331.GA8878@elte.hu> <20050410103805.7eee2fea.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410103805.7eee2fea.pj@engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@engr.sgi.com> wrote:

> Ingo wrote:
> > With default gzip it's 3.3 seconds though,
> > and that still compresses it down to 57 MB.
> 
> Interesting.  I'm surprised how much a bunch of separate, modest sized
> files can be compressed.

sorry, what i measured was in essence the tarball. I.e. not the 
compression of every file separately. I should have been clear about 
that ...

	Ingo
