Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264232AbTDWTzq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264233AbTDWTzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:55:42 -0400
Received: from zok.sgi.com ([204.94.215.101]:7357 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264231AbTDWTzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:55:38 -0400
Date: Wed, 23 Apr 2003 13:07:22 -0700
From: richard offer <offer@sgi.com>
To: Christoph Hellwig <hch@infradead.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
cc: Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Stephen Tweedie <sct@redhat.com>, lsm <linux-security-module@wirex.com>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
Message-ID: <1438650000.1051128442@changeling.engr.sgi.com>
In-Reply-To: <20030423202614.A5890@infradead.org>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil>
 <20030423191749.A4244@infradead.org>
 <20030423112548.B15094@figure1.int.wirex.com>
 <20030423194501.B5295@infradead.org>
 <1051125476.14761.146.camel@moss-huskers.epoch.ncsc.mil>
 <20030423202614.A5890@infradead.org>
X-Mailer: Mulberry/2.2.0 (Linux/x86)
X-HomePage: http://www.whitequeen.com/users/richard/
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



* frm hch@infradead.org "04/23/03 20:26:15 +0100" | sed '1,$s/^/* /'
*
* 
* And all these should _not_ happen in the actual tools but in a
* pluggable security module (something like pam).  

I proposed something along those lines back in 2001 at the USENIX security
conference LSM BOF---I called it PACM. 

But it seemed that no-one else was interested in policy independent
userland interfaces or applications (X, sendmail) making policy decisions.


richard.

-- 
-----------------------------------------------------------------------
Richard Offer                     Technical Lead, Trust Technology, SGI
"Specialization is for insects"
_______________________________________________________________________

