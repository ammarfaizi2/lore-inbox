Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263170AbRFETRz>; Tue, 5 Jun 2001 15:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263172AbRFETRp>; Tue, 5 Jun 2001 15:17:45 -0400
Received: from web13704.mail.yahoo.com ([216.136.175.137]:42511 "HELO
	web13704.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263170AbRFETRg>; Tue, 5 Jun 2001 15:17:36 -0400
Message-ID: <20010605191735.28928.qmail@web13704.mail.yahoo.com>
Date: Tue, 5 Jun 2001 12:17:35 -0700 (PDT)
From: jalaja devi <jala_74@yahoo.com>
Subject: smp errors in 2.4!!
To: linux-kernel@vger.kernel.org
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE2AB@orsmsx31.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I encounter this compilation error:
/usr/x.c:2112: struct has no member named
"event_Rsmp_7b16c344"

The structure has that field and I don't have the
conflicting structure name anywhere in my code and in
the system files too. 

The makefile uses sed and *.d files.

Could anyone help me out as how to fix this.

Thanks
Jalaja


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
