Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbTJRXD4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 19:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTJRXD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 19:03:56 -0400
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:35969
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S261925AbTJRXD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 19:03:56 -0400
From: John Mock <kd6pag@qsl.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: test8: 'Debug: sleeping function called from invalid context'
Message-Id: <E1AB079-0001Yf-00@penngrove.fdns.net>
Date: Sat, 18 Oct 2003 16:04:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I came across two different ones early in the boot process while chasing 
down another bug.  They seem to be fairly benign, but someone may want to
track this down:

    dmesg:    http://bugzilla.kernel.org/attachment.cgi?id=1091
    .config:  http://bugzilla.kernel.org/attachment.cgi?id=1092

Don't worry about anything past CPU initialization, it's persumably 
unrelated.  I hope someone finds this helpful.  Please let me know if 
you would like additional information.
					  -- JM
