Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbVE0STI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbVE0STI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 14:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVE0STH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 14:19:07 -0400
Received: from web33008.mail.mud.yahoo.com ([68.142.206.72]:26982 "HELO
	web33008.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262511AbVE0SS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 14:18:56 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=NCKjC2YUg0E1e5kuuy5lE2yKugXfq3bGEVKkwSSi8RB6pZoaowZqlaahMKKOXHQPbew9tda+1KK/12VVk3i7ggW3NclfizuKHlSqSShuEAgTptrN2N3S+Rq7vJR1NcOKlMrnXPITVyw8Lwzv5OsvThVjYMP8yJV7+qsSIMcCqjg=  ;
Message-ID: <20050527181851.69524.qmail@web33008.mail.mud.yahoo.com>
Date: Fri, 27 May 2005 11:18:51 -0700 (PDT)
From: cranium2003 <cranium2003@yahoo.com>
Subject: kernel memory usage any restrictions?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
              Is there any restricition on using
kernel's memory? also if i require to use some kernel
memory say 625kB by allocating that in GFP_ATOMIC mode
flag, what will be the side effects on kernel memory
if i use that 625kB memory available from kernel
memory for my kernel source code additions to kernel?
I require answer with respect to 2.4 and 2.6 kernel.
regards,
cranium. 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
