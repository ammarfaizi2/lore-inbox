Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbUCSTXY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 14:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbUCSTXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 14:23:23 -0500
Received: from ns.suse.de ([195.135.220.2]:6280 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263163AbUCSTXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 14:23:15 -0500
Date: Fri, 19 Mar 2004 20:23:15 +0100
From: Andi Kleen <ak@suse.de>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: jim.houston@comcast.net, akpm@osdl.org, linux-kernel@vger.kernel.org,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: Fixes for .cfi directives for x86_64 kgdb
Message-Id: <20040319202315.3c01a501.ak@suse.de>
In-Reply-To: <200403191847.43692.amitkale@emsyssoft.com>
References: <m33c8788ac.fsf@new.localdomain>
	<m3ekrqdroy.fsf@new.localdomain>
	<200403191847.43692.amitkale@emsyssoft.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004 18:47:43 +0530
"Amit S. Kale" <amitkale@emsyssoft.com> wrote:

> Thanks. Checked into kgdb.sourceforge.net cvs tree

It's not very useful because that tree still has the broken
"interrupt threads" support.

-Andi
