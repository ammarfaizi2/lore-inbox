Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266118AbTLIURG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266103AbTLIUP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:15:26 -0500
Received: from zeus.kernel.org ([204.152.189.113]:37280 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S266102AbTLIUPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:15:15 -0500
Date: Tue, 9 Dec 2003 22:47:54 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Device-mapper submission for 2.4
Message-ID: <20031209194754.GR30105@stingr.net>
Mail-Followup-To: Linux Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0312091206490.1289-100000@logos.cnet> <200312091145.04511.kevcorry@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200312091145.04511.kevcorry@us.ibm.com>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Kevin Corry:
> prevent JBD and Device-Mapper from stepping on each other's private data. The 
> second patch (mempool) only adds new functionality that won't affect any 
> existing code. (I'm actually suprised the mempool code hasn't been merged 
> yet, since it would be quite useful for any number of drivers and/or 

alan had mempool in -ac for more than a year ;(

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
