Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWACUZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWACUZc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWACUZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:25:32 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:38311 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751478AbWACUZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:25:31 -0500
Subject: [patch 0/9] slab cleanups
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       colpatch@us.ibm.com, rostedt@goodmis.org, clameter@sgi.com,
       penberg@cs.helsinki.fi
Date: Tue, 03 Jan 2006 22:25:29 +0200
Message-Id: <1136319929.8629.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

[Sorry for sending these twice. My send mbox script failed miserably
 and this batch is sent by hand. Does anyone have one a script that
 works with quilt?]

Here's some pending slab cleanup patches from various people. Please note
that the patch "slab: distinguish between object and buffer size" is a
replacement for the objsize renaming patch you have sitting in -mm.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

