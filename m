Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264444AbUDVQOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUDVQOH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 12:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264541AbUDVQOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 12:14:06 -0400
Received: from [63.161.72.3] ([63.161.72.3]:22976 "EHLO
	mail.standardbeverage.com") by vger.kernel.org with ESMTP
	id S264444AbUDVQLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 12:11:32 -0400
Message-ID: <6ced92039bd020302f1a48705418ddbb@stdbev.com>
Date: Thu, 22 Apr 2004 11:24:00 -0500
From: "Jason Munro" <jason@stdbev.com>
Subject: ACPI suspend to RAM weirdness
To: linux-kernel@vger.kernel.org
Reply-to: <jason@stdbev.com>
X-Mailer: Hastymail 1.0-rc2-CVS
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   I can sucessfully suspend with 'echo 3 > /proc/acpi/sleep' on my Toshiba
Satellite 1410-S173. It also wakes up fine, except after waking it jumps to
init 0 and shuts down. It's been this way with every kernel I have tried
since 2.6.4. I know it worked with 2.6.1 but I'm not sure exactly at what
point between that and 2.6.4 it changed, or even if this is a userspace or
kernel issue. Yesterday I tried with 2.6.6-rc2 and rc2-mm1 and it still
behaves the same.

Any suggestions?

tia,

\__ Jason Munro
 \__ jason@stdbev.com
  \__ http://hastymail.sourceforge.net/


