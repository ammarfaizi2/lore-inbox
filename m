Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbTJXCTv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 22:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbTJXCTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 22:19:51 -0400
Received: from quechua.inka.de ([193.197.184.2]:22217 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261940AbTJXCTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 22:19:50 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: posix capabilities inheritance
Organization: Deban GNU/Linux Homesite
In-Reply-To: <200310240136.h9O1aaOU002931@pasta.boston.redhat.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.2-20031002 ("Berneray") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E1ACrXi-0000oW-00@calista.eckenfels.6bone.ka-ip.net>
Date: Fri, 24 Oct 2003 04:19:10 +0200
X-Scanner: exiscan *1ACrXi-0000oW-00*MlC1ULdlg7c*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200310240136.h9O1aaOU002931@pasta.boston.redhat.com> you wrote:
> However, I agree that it's often not viable to require application
> changes to achieve the desired result.

What does often mean? This is the Open Source Linux, and here we can do
changes to the source if it is good for securtiy, architecture, speat,
whatever.

Of course a solution which does the right thing without programming is even
better - Watermarking or something. But I guess wie can combine those. The
typical internet server has already enough cruft for chrooting, priveledge
dropping and FD passing to work around for example port priveledges, a REAL
solution wont make it worse.

Bernd
y
