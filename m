Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268052AbUIBJgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268052AbUIBJgW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 05:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268054AbUIBJgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 05:36:22 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:60372 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268052AbUIBJgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 05:36:21 -0400
Date: Thu, 2 Sep 2004 02:36:25 -0700
From: Paul Jackson <pj@sgi.com>
To: V13 <v13@priest.com>
Cc: alan@lxorguk.ukuu.org.uk, davidsen@tmr.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Root reservations for strict overcommit
Message-Id: <20040902023625.58740735.pj@sgi.com>
In-Reply-To: <200408312249.36218.v13@priest.com>
References: <20040831143449.GA26680@devserv.devel.redhat.com>
	<ch2b68$985$1@gatekeeper.tmr.com>
	<1093970232.611.16.camel@localhost.localdomain>
	<200408312249.36218.v13@priest.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Noone should have to reserve 120MB for root on a 4G box. 

Much less 120GB on a 4T box ;)

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
