Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbVCDFBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbVCDFBE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 00:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbVCDE7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 23:59:53 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:40341 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261500AbVCDE0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 23:26:50 -0500
Subject: Re: RFD: Kernel release numbering
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, greg@kroah.com, jgarzik@pobox.com,
       torvalds@osdl.org, davem@davemloft.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050303160330.5db86db7.akpm@osdl.org>
References: <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>
	 <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>
	 <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com>
	 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	 <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com>
	 <20050303151752.00527ae7.akpm@osdl.org>
	 <20050303234523.GS8880@opteron.random>
	 <20050303160330.5db86db7.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 23:26:30 -0500
Message-Id: <1109910390.4768.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 16:03 -0800, Andrew Morton wrote:
> Or, to put it another way, we're getting a small number of irritating
> regressions, mainly in device drivers which is giving the whole thing a bad
> rep.  Is there some way in which we can fix that problem without
> reinventing the whole world?

This seems to be a damn hard problem.  For example I can't think of any
reasonable release candidate process that would have prevented that
guy's sound problem with the Thinkpad and the docking station.  Without
comprehensive hardware documentation, as long as there are more
different types of hardware then there are people who can hack drivers,
I think this will be an issue.

Lee

