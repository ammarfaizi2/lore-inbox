Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263065AbUB0RSt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 12:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263068AbUB0RSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 12:18:48 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:55525 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263065AbUB0RSW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 12:18:22 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16447.31708.873806.565855@laputa.namesys.com>
Date: Fri, 27 Feb 2004 20:18:20 +0300
To: markw@osdl.org
Cc: reiser@namesys.com, piggin@cyberone.com.au, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: AS performance with reiser4 on 2.6.3
In-Reply-To: <200402271704.i1RH45E19258@mail.osdl.org>
References: <403EBB87.2070504@namesys.com>
	<200402271704.i1RH45E19258@mail.osdl.org>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

markw@osdl.org writes:
 > 
 > Yes, PostgreSQL uses fsync for its database logging.  I can certainly
 > enable the capture on copy option.  

Please don't, it is not stable enough yet.

 >                                     Does that produce something that I
 > need to manually capture?
 > 
 > Mark

Nikita.
