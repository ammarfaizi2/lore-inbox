Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbTJAKGi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 06:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbTJAKGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 06:06:38 -0400
Received: from twix.hotpop.com ([204.57.55.70]:49541 "EHLO twix.hotpop.com")
	by vger.kernel.org with ESMTP id S261463AbTJAKGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 06:06:37 -0400
Subject: 2.6.0-test6 Quake3/Wolfenstein Lockups
From: Dan <overridex@punkass.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1065002791.5548.5.camel@nazgul.overridex.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 01 Oct 2003 06:06:31 -0400
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I'm experiencing frequent hard lockups (magic sysrq doesn't even work)
when exiting quake3 or return to castle wolfenstein on 2.6.0-test5 and
test6... they happen about 50% of the time, and usually my quake3 config
file is missing when I boot back up.  They only happen after clicking to
bypass the credits screens when exiting the games... is anyone
experiencing this?  I'm unable to strace quake3 as it won't start up at
all when straced, and I can't get return to castle wolfenstein to lockup
when it's straced.  I'm running a dual athlon 1700 machine, with
reiserfs and LVM.  This lockup doesn't happen on 2.4.x nor did it happen
on 2.5.72 (though at the time I was running raid-0 and not lvm) If
anyone else is having this problem I'd like to hear it, or if anyone
else wants info just let me know.  Please cc me any replies. -Dan


