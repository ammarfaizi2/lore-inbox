Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267863AbUIJT43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267863AbUIJT43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 15:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267860AbUIJT42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 15:56:28 -0400
Received: from [213.217.113.151] ([213.217.113.151]:334 "EHLO fjoras.ohse.de")
	by vger.kernel.org with ESMTP id S267866AbUIJT4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 15:56:25 -0400
Date: 10 Sep 2004 19:54:06 -0000
Message-ID: <20040910195406.20598.qmail@fjoras.ohse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040910.105040.30177815.wscott@bitmover.com>
From: uwe@ohse.de (Uwe Ohse)
References: <1094797973.4838.4.camel@almond.st-and.ac.uk>
	<4141504B.8030104@namesys.com>
	<4141CCA2.9010005@techsource.com>
Organization: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne Scott wrote:

>One advantage of ':' is that portable programs already have to avoid
>it because of NTFS alternate data streams:

this is not going to work:

lynx www.site.tld:8080
ls /usr/share/man/man3/*::*            ## perl stuff
http://cr.yp.to/proto/maildir.html

Regards, Uwe
