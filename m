Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263456AbVCMFqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263456AbVCMFqh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 00:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263458AbVCMFqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 00:46:36 -0500
Received: from hacksaw.org ([66.92.70.107]:35987 "EHLO hacksaw.org")
	by vger.kernel.org with ESMTP id S263456AbVCMFqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 00:46:30 -0500
Message-Id: <200503130546.j2D5kOqc029443@hacksaw.org>
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: indirect lcall without `*'
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 13 Mar 2005 00:46:24 -0500
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In compiling 2.4.29 I get this during the compilation of pci-pc.c:

Warning: indirect lcall without `*'

I note from looking around the net that this is an old "problem", dating back 
at least to 2.4.18, if not earlier.

What does it mean? Should I care? If I shouldn't, shouldn't there be a message 
somewhere in the build process that says "This isn't a problem" so people 
don't write to lkml and ask about it?

Thanks in advance for your time and consideration.
-- 
That which is impossible has become necessary.
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


