Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266248AbUG0E2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266248AbUG0E2j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 00:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266246AbUG0E2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 00:28:39 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:63449 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266254AbUG0E0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 00:26:54 -0400
Subject: Re: [PATCH 2.6.8-rc2] intel8x0.c to include CK804 audio support
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrew Chew <achew@nvidia.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
In-Reply-To: <20040726173806.7cc0e9d5.akpm@osdl.org>
References: <DBFABB80F7FD3143A911F9E6CFD477B03F95DD@hqemmail02.nvidia.com>
	 <20040726173806.7cc0e9d5.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1090902426.1094.33.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Jul 2004 00:27:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-26 at 20:38, Andrew Morton wrote:
> "Andrew Chew" <achew@nvidia.com> wrote:
> >
> > This patch updates include/linux/pci_ids.h with the CK804 audio
> >  controller ID, and adds the CK804 audio controller to the
> >  sound/pci/intel8x0.c audio driver.
> 
> I'm getting many workwrapped and tab-replaced patches nowadays.  Could
> people pleeeeze ensure that their email clients are sending unmangled
> patches?
> 
> I fixed this one up.  I usually do :(
> 

The problem is not people's email clients, the problem is that xterm,
gnome-terminal, and konsole all mangle tabs to spaces when copying
text.  There is nothing the mailer can do about it.  For now the only
fix for people using an X environment is to pipe to a text file and then
use their email client's 'insert file' feature.  There is an open Debian
bug report for xterm regarding this issue, I encourage everyone bothered
by this to add comments.

I realize it has always been this way, but people coming from any other
OS expect to be able to copy and paste a tab and have it stay a tab.

Many other devel lists encourage patches be sent as MIME attachents due
to this issue.  I would prefer that the console apps be fixed.

Lee

