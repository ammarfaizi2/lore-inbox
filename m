Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265837AbUBJLkZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 06:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265841AbUBJLkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 06:40:25 -0500
Received: from dsl-082-083-128-026.arcor-ip.net ([82.83.128.26]:37769 "EHLO
	server1.intern.kubla.de") by vger.kernel.org with ESMTP
	id S265837AbUBJLkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 06:40:24 -0500
Date: Tue, 10 Feb 2004 12:40:22 +0100
From: Dominik Kubla <dominik@kubla.de>
To: Albert Cahalan <albert@users.sf.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Does anyone still care about BSD ptys?
Message-ID: <20040210114022.GC1229@intern.kubla.de>
References: <1076334541.27234.140.camel@cube> <4027BFE7.5040100@zytor.com> <1076347137.27234.166.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076347137.27234.166.camel@cube>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I should mention here that the SysV pty stuff
> is nearly 100% undocumented in the man pages.
> I get nothing for pts, pty, grantpt...

Update your system! manpages-1.62 includes:

getpt(3)
grantpt(3)
ptsname(3)
unlockpt(3)
pts(4)
ptmx(4)

Now that should be sufficient, shouldn't it?

Regards,
  Dominik Kubla
-- 
In buying horses and taking a wife shut your eyes tight and commend
yourself to God.
