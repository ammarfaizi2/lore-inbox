Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSGHTxL>; Mon, 8 Jul 2002 15:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSGHTxL>; Mon, 8 Jul 2002 15:53:11 -0400
Received: from r-fi057-2b122.tin.it ([62.211.53.122]:28802 "EHLO
	penny.ik5pvx.ampr.org") by vger.kernel.org with ESMTP
	id <S315536AbSGHTxK>; Mon, 8 Jul 2002 15:53:10 -0400
To: linux-kernel@vger.kernel.org
Subject: Warning: /proc/ksyms not normal
Reply-To: Pierfrancesco Caci <p.caci@tin.it>
From: Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org>
Date: 08 Jul 2002 21:55:46 +0200
Message-ID: <87d6tyuh8d.fsf@penny.ik5pvx.ampr.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
since a couple of days I'm getting this strange message:

root@penny:~ # ps
Warning: /proc/ksyms not normal               <-------- this one !
  PID TTY      STAT   TIME COMMAND
 6354 vc/2     S      0:00 /sbin/getty 38400 vc/2
...


kernel is 2.4.19-pre8, and apart from a couple of "apt-get dselect-upgrade" 
2 days ago and today, I've not changed anything else. Oh, I'm tracking
debian unstable, if that may mean something.

I wish I could know where this message is coming from....


Thanks


Pf


-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.19-pre8 #1 Sat May 11 10:04:21 CEST 2002 i686 unknown

