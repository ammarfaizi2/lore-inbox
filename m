Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVDJRzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVDJRzu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 13:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVDJRzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 13:55:50 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:20103 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261538AbVDJRzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 13:55:45 -0400
Date: Sun, 10 Apr 2005 19:55:39 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Martin Pool <mbp@sourcefrog.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       David Lang <dlang@digitalinsight.com>
Subject: Re: Kernel SCM saga..
Message-ID: <20050410175539.GA8201@merlin.emma.line.org>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Martin Pool <mbp@sourcefrog.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Lang <dlang@digitalinsight.com>
References: <20050407014727.GA17970@havoc.gtf.org> <pan.2005.04.07.02.25.56.501269@sourcefrog.net> <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz> <1112852302.29544.75.camel@hope> <Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org> <1112939769.29544.161.camel@hope> <Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org> <20050408083839.GC3957@opteron.random> <Pine.LNX.4.58.0504081647510.28951@ppc970.osdl.org> <20050409022701.GA14085@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050409022701.GA14085@opteron.random>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli schrieb am 2005-04-09:

> On Fri, Apr 08, 2005 at 05:12:49PM -0700, Linus Torvalds wrote:
> > really designed for something like a offline http grabber, in that you can 
> > just grab files purely by filename (and verify that you got them right by 
> > running sha1sum on the resulting local copy). So think "wget".
> 
> I'm not entirely convinced wget is going to be an efficient way to
> synchronize and fetch your tree, its simplicitly is great though. It's a

wget is probably a VERY UNWISE choice:

<http://www.derkeiler.com/Mailing-Lists/securityfocus/bugtraq/2004-12/0106.html>

-- 
Matthias Andree
