Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbTLGL4E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 06:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264415AbTLGL4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 06:56:04 -0500
Received: from stingr.net ([212.193.32.15]:33472 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S264411AbTLGL4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 06:56:02 -0500
Date: Sun, 7 Dec 2003 14:56:00 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Subject: Re: amanda vs 2.6
Message-ID: <20031207115600.GM30105@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200311261212.10166.gene.heskett@verizon.net> <200311291214.33130.gene.heskett@verizon.net> <20031201184357.GI1566@mis-mike-wstn.matchmail.com> <200312012141.01223.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200312012141.01223.gene.heskett@verizon.net>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Gene Heskett:
> Formerly rh8.0 with almost all updates, eg if its still an rpm, I let 
> update do it.  Hand built stuffs like cups and sane are newer than 
> 8.0, as is the currently working kde-3.1.1a.  Obviously I don't let 
> up2date anywhere near that stuff.

seems that you have nsswitch problem.

I encountered same behavior with latest stable gentoo, 2.6 kernel and
nss_mysql. Upgrade to latest glibc + nptl solved this.

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
