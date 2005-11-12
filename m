Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbVKLUjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbVKLUjU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 15:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbVKLUjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 15:39:20 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:7110 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964788AbVKLUjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 15:39:19 -0500
Date: Sat, 12 Nov 2005 12:38:57 -0800
From: Paul Jackson <pj@sgi.com>
To: Alexander Nyberg <alexn@telia.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Some debugging patches on top of -mm
Message-Id: <20051112123857.2d2bff6e.pj@sgi.com>
In-Reply-To: <1131827167.12287.5.camel@c213-100-52-74.swipnet.se>
References: <20050905195001.GA10223@localhost.localdomain>
	<20051112031320.40543ae4.pj@sgi.com>
	<1131827167.12287.5.camel@c213-100-52-74.swipnet.se>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you wish to make it nicer/mergeable it's all yours.

Nah - I just wanted those ugly ifdef's out of page_alloc.c.

I sure don't want to own it.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
