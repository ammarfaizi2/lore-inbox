Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265030AbSJPPjF>; Wed, 16 Oct 2002 11:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265111AbSJPPjE>; Wed, 16 Oct 2002 11:39:04 -0400
Received: from stud3.tuwien.ac.at ([193.170.75.13]:35566 "EHLO
	stud3.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S265030AbSJPPjE>; Wed, 16 Oct 2002 11:39:04 -0400
Date: Wed, 16 Oct 2002 17:44:59 +0200
From: Stefan Schwandter <swan@shockfrosted.org>
To: linux-kernel@vger.kernel.org
Subject: Posix capabilities
Message-ID: <20021016154459.GA982@TK150122.tuwien.teleweb.at>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,


I saw capabilities and acl patches for ext2/3 enter -mm. Is it possible
now to give an executable (that lives on an ext2/ext3 fs) the necessary
rights to use SCHED_FIFO without being setuid root? Could someone give
me some pointers for these topics (capabilities support in linux, acl)?


regards, Stefan
-- 
----> http://www.shockfrosted.org
