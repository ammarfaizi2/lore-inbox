Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317423AbSFROVe>; Tue, 18 Jun 2002 10:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317424AbSFROVd>; Tue, 18 Jun 2002 10:21:33 -0400
Received: from web13202.mail.yahoo.com ([216.136.174.187]:7713 "HELO
	web13202.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317423AbSFROVc>; Tue, 18 Jun 2002 10:21:32 -0400
Message-ID: <20020618142133.53974.qmail@web13202.mail.yahoo.com>
Date: Tue, 18 Jun 2002 07:21:33 -0700 (PDT)
From: "X.Xiao" <joyhaa@yahoo.com>
Subject: static inline vs. extern inline;  inline vs.  __inline__
To: linux-kernel@vger.kernel.org
In-Reply-To: <yrxn0ts65vh.fsf@catbert.mcs.anl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After seeing various 'static inline', 'extern inline',
'inline' and '__inline__' in the kernel source, and
reading GCC's Inline subsection, it's still hard to
use them in a clear way:
1. what's the key difference between 'static' and
'extern' for inline? is there a rule to pick which one
during development(such as library or driver coding)
2. what's the difference between 'inline' and
'__inline__'?

I wish the answer were in FAQ but it's not.

Thanks a lot!
X.Xiao

__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
