Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278128AbRJLUzB>; Fri, 12 Oct 2001 16:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278134AbRJLUyv>; Fri, 12 Oct 2001 16:54:51 -0400
Received: from web13801.mail.yahoo.com ([216.136.175.11]:53522 "HELO
	web13801.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S278128AbRJLUyo>; Fri, 12 Oct 2001 16:54:44 -0400
Message-ID: <20011012205512.40709.qmail@web13801.mail.yahoo.com>
Date: Fri, 12 Oct 2001 13:55:12 -0700 (PDT)
From: Chris HOOVER <revoohc@yahoo.com>
Subject: make xconfig idea?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

  I'm interested in trying to help with the linux
kernel development.  As a starting point, I was
thinking of trying to fix a some what annoying feature
with the make xconfig.

  It seems that if you disable support for a major
catagory (i.e. scsi, sound, etc) and you click next,
it should go to the next major catagory.  However,
xconfig currently takes you to the next sub-menu, not
to the next major menu.

  Are there any compelling reasons why xconfig should
not function this way?  If not, then I will try to
code this new logic up.

Thanks for any input,

Chris

__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
