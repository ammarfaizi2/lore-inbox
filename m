Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263266AbTIGOGM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 10:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTIGOGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 10:06:12 -0400
Received: from dsl2-09018-wi.customer.centurytel.net ([209.206.215.38]:48549
	"HELO thomasons.org") by vger.kernel.org with SMTP id S263266AbTIGOGL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 10:06:11 -0400
Date: Sun, 7 Sep 2003 09:06:10 -0500
From: Scott Thomason <scott@thomasons.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Forcing CONFIG_X86_IO_APIC=n
Message-Id: <20030907090610.4a47ec2a.scott@thomasons.org>
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to try forcing CONFIG_X86_IO_APIC=n while I test 2.6.0-test4,
but apparently some part of the kernel build re-runs my .config thru
something and keeps changing it back to 'y'. Is there any way to
accomplish this?
---scott
