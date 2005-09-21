Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbVIURqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbVIURqi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVIURqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:46:38 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:58286 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751314AbVIURqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:46:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:User-Agent:Cc:MIME-Version:Content-Disposition:Date:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=05BYNTYPtXW5UGxe8KOGrdM4hXAQQEKgSOu9jnhkwGgHlqZvsyQ7HX4giUUlgQEHvhT7SOyycVVp+asWAKp4GArhRnytC1/j8RQ572DbCxAECskRiNk7jXKsZVJzFdTddZ8h6RM28BVlgTCs0xan4SkvsnOEKY/eofNAI5Wd27s=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/10] "Bigger" UML fixes for 2.6.14
User-Agent: KMail/1.8.2
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Date: Wed, 21 Sep 2005 19:23:20 +0200
Message-Id: <200509211923.21861.blaisorblade@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a collection of more intrusive UML fixes for 2.6.14.

However, I've been careful in them (at least so I hope). You may want to put 
some in -mm, but please let's make sure that they get into -mm.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
