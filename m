Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbTD2Wmy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 18:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTD2Wmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 18:42:54 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:39819 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261835AbTD2Wmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 18:42:52 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304292259.h3TMx0XL004194@81-2-122-30.bradfords.org.uk>
Subject: Kernel Bug Database 3.1 On-line
To: linux-kernel@vger.kernel.org
Date: Tue, 29 Apr 2003 23:59:00 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just put version 3.1 of my Kernel Bug Database on-line, (yes,
version 3.0 was on-line for about five minutes, and I found a bug :-) ).

http://grabjohn.com/kernelbugdatabase/

This verison is a major update, with the highlights being:

* Lots of cosmetic changes, making it easier and nicer to use.
* Access without logging in is now more transparent, (you don't get a
  session unless you log in, so it won't time out, or prompt you to
  log out, unless you actually log in). 
* The searching of bug reports and confirmed bugs interfaces are now
  combined in a single interface, but they are both separate sets of
  data, and you can choose to search either or both.
* You can now use an existing post to LKML as the basis for a bug
  report - so if you've posted a bug report to LKML, you can now
  import it in to the Kernel Bug Database semi-automatically.
* Added a password reminder function.
* The actual text of bug reports and confirmed bugs is now stored
  separately from the on-going discussion of them, (existing bug
  reports and confirmed bugs haven't had this separated out yet, but I
  will do it in the near future).
* Various bugfixes.

As always, feedback on the Kernel Bug Database would be much
appreciated.  I haven't updated the documentation to document version
3.1 yet, but it should be fairly self-explainatory.

John.
