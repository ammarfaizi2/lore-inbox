Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbTI3VcC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 17:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbTI3VcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 17:32:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:17598 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261731AbTI3Vb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 17:31:58 -0400
Date: Tue, 30 Sep 2003 14:31:49 -0700
From: cliff white <cliffw@osdl.org>
To: linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: 2.6.0-test5 - stuck keys on iBook
Message-Id: <20030930143149.4930ec9c.cliffw@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kernel version: latest from ppc.bkbits.net/linuxppc-2.5

Symptom: keyboard diarrhea - single keypress == 3-7 characters.

I've tried reverting drivers/input/keyboards/atkbd.c back to v1.31, doesn't
change anything.

Haven't done much other debug, since i can't successfully login to the system
from console. 

Further information if needed.
Please cc me if you reply from linuxppc-dev, i am not on that group.

cliffw
cliffw@osdl.org
