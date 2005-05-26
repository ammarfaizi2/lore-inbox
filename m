Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVEZOjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVEZOjn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 10:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVEZOjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 10:39:43 -0400
Received: from web33010.mail.mud.yahoo.com ([68.142.206.74]:24184 "HELO
	web33010.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261523AbVEZOja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 10:39:30 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=6BEqri1fSZ8DylD00o672vWvvYpDtQMRQK2Gv6rkRfCCG4ic2hD84y1oPKHPyBM2OKZsJA0vsoJqIGmNCivvVFDoH6MUqw4sMaO4Ga2dzZrwxbkM4UQHm+15bVw/rZnLvoMpF82p4x48KtkhN38GzTDl5EtOa53Ul0/iBaKDrNw=  ;
Message-ID: <20050526143926.69208.qmail@web33010.mail.mud.yahoo.com>
Date: Thu, 26 May 2005 07:39:26 -0700 (PDT)
From: cranium2003 <cranium2003@yahoo.com>
Subject: getting eth1: Memory squeeze, dropping packet message
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
       While transmitting packets through linux Router
host from one network to another Redhat linux 9 kernel
2.4.20-8 caught kernel oops following there are 2
statements which are
__alloc_pages: 0 order allocation failed (gfp =
0x20/1)
eth1: Memory squeeze, dropping packet
What this means? where is the wrong thing in kenrel?
How to solve this problem?
regards,
cranium.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
