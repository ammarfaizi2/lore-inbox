Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVDJCJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVDJCJY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 22:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVDJCJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 22:09:23 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:17027 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261193AbVDJCJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 22:09:15 -0400
Date: Sat, 9 Apr 2005 19:09:03 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: pasky@ucw.cz, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-Id: <20050409190903.4efd46da.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	<20050409200709.GC3451@pasky.ji.cz>
	<Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then a "tree" object would point to a "directory" object, 

Ah - light bulb flickers - in _separate_ files.

Yes, that obviously makes a difference.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
