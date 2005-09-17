Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbVIQLQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVIQLQY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 07:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbVIQLQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 07:16:24 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:59803 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751067AbVIQLQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 07:16:23 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Date: Sat, 17 Sep 2005 14:15:50 +0300
User-Agent: KMail/1.8.2
Cc: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
References: <432AFB44.9060707@namesys.com> <20050917092247.GA13992@infradead.org> <200509171356.14497.vda@ilport.com.ua>
In-Reply-To: <200509171356.14497.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509171415.50454.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At least reiser4 is smaller. IIRC xfs is older than reiser4 and had more time
> to optimize code size, but:
> 
> reiser4        2557872 bytes
> xfs            3306782 bytes

And modules sizes:

reiser4.ko        442012 bytes
xfs.ko            494337 bytes
--
vda
