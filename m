Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbTEJUFF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 16:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbTEJUFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 16:05:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48831 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264487AbTEJUFE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 16:05:04 -0400
Date: Sat, 10 May 2003 21:17:44 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: logs full of chatty IDE cdrom
Message-ID: <20030510201744.GD662@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.5.69 (i686)
X-Uptime: 21:14:06 up  9:12,  1 user,  load average: 0.00, 0.04, 0.07
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I'm not sure but this seems to be a lot worse in 2.5.x for some
reason; my logs are full of I/O errors, not ready's and other errors from
my CDROM drive that is playing audio CDs; I suspect at least some of it
is due to kscd trying to figure out if there is a CD in an empty drive.

Is there any way to selectively silence errors from one IDE device? It
would make it easier to spot real/important errors from hard drives and the
like.

Dave
  
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
