Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273252AbTHPXtl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 19:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274980AbTHPXtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 19:49:41 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:48778 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S273252AbTHPXtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 19:49:40 -0400
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David D. Hagood" <wowbagger@sktc.net>
Cc: Valdis.Kletnieks@vt.edu, Michael Frank <mhf@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F3EB8FA.1080605@sktc.net>
References: <200308170410.30844.mhf@linuxmail.org>
	 <200308162049.h7GKnwnP024716@turing-police.cc.vt.edu>
	 <3F3EB8FA.1080605@sktc.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061077758.11351.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 17 Aug 2003 00:49:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-17 at 00:06, David D. Hagood wrote:
> > Your logfiles just got DoS'ed....
> 
> 
> Why not then just log uncaught exceptions?

man acct

