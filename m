Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVB1A5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVB1A5P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 19:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVB1A5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 19:57:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19947 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261523AbVB1A45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 19:56:57 -0500
Date: Sun, 27 Feb 2005 19:56:53 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Wen Xiong <wendyx@us.ibm.com>
cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [ patch 6/7] drivers/serial/jsm: new serial device driver
In-Reply-To: <42225A64.6070904@us.ltcfwd.linux.ibm.com>
Message-ID: <Pine.LNX.4.61.0502271956130.19979@chimarrao.boston.redhat.com>
References: <42225A64.6070904@us.ltcfwd.linux.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.61.0502271956132.19979@chimarrao.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2005, Wen Xiong wrote:

> This patch is all headers for this device driver.
> 
> Signed-off-by: Wen Xiong <wendyx@us.ltcfwd.linux.ibm.com>

+++ linux-2.6.9.new/drivers/serial/jsm/digi.h   2005-02-27
17:14:44.746952168 -0600
@@ -0,0 +1,416 @@
+/*
+ * Copyright 2003 Digi International (www.digi.com)
+ *     Scott H Kilau <Scott_Kilau at digi dot com>
+ *

Not signed off by the copyright holder.  Not sure how
much of a problem this is, but something to think about.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
