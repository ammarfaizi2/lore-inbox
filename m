Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751653AbWIAPhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbWIAPhk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbWIAPhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:37:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34519 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751649AbWIAPhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:37:39 -0400
Subject: Re: Environment that was used for building/testing of kernel
	2.6.x.y
From: Arjan van de Ven <arjan@infradead.org>
To: Peter Lezoch <pledr@t-online.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1GJAsz-0VDsJ60@fwd27.sul.t-online.de>
References: <1GJAsz-0VDsJ60@fwd27.sul.t-online.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 01 Sep 2006 17:37:22 +0200
Message-Id: <1157125042.2863.57.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 15:25 +0000, Peter Lezoch wrote:
> please include in each distributed kernel version a file with the output of scripts/linux-ver, so, that the user might see under what environment the kernel was built and tested. All info that I found about compiler versions was years old.

Hi,

the compiler version is actually included in the VERMAGIC already ;)
also if you type "dmesg | head -2" you get to see the full version of
the compiler that was used.... What more would you want?

Greetings,
   Arjan van de Ven

