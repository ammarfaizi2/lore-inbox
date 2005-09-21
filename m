Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbVIUQXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVIUQXf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVIUQXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:23:35 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:25681 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751128AbVIUQXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:23:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=WsH/YZQLgK4AxNRWqgtGkDs0+FVt5lcrkqGIeOWJMk6iuM4S3WVIrsiKpvMxuURdblvUci1voLJ4HATqpMQYrhKB22NIi5Vg5ooNvvGh9vO1DsmvT9uGnAsL8wowkmfUkAVpwQu+lDzmLhm3DrCm5LwEhdQuMUB36JoI0ssIgDU=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 0/10] Lots of UML fixups for 2.6.14
Date: Wed, 21 Sep 2005 18:22:15 +0200
User-Agent: KMail/1.8.2
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509211822.17590.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a collection of simple fixes like "fix warning", "rename thing to fix 
conflict", "remove unused var ", "add comment", "match function and proto", 
"missing break in switch".

This is the "trivial" part of my UML tree - can this get merged upstream? 
Thanks.

I'll later send another bunch of more troublesome fixes.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
