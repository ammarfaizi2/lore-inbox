Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbTDISbH (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 14:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263657AbTDISbG (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 14:31:06 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:41673 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S263288AbTDISbG (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 14:31:06 -0400
Subject: glibc+sysenter sources..?
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: drepper@redhat.com
Content-Type: text/plain
Organization: 
Message-Id: <1049913600.18782.24.camel@sparky>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Apr 2003 14:40:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found the binaries (ftp://people.redhat.com/drepper/glibc/2.3.1-25/)
but the sources don't seem to be available.  (That makes it hard to
test, since my 2.5 system is running debian..)

Preferable would be a patch against the standard 2.3.1 (rather than one
against the redhat sources) but I can probably detangle it if needed.

Also, has this been tested under SMP or am I forging new ground? (dual
ppro 200 system under 2.5.66-bk10.)

-- 
Disconnect <lkml@sigkill.net>

