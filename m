Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267414AbUIOUk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267414AbUIOUk4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267360AbUIOUjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:39:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:22168 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S267382AbUIOUir
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:38:47 -0400
Date: Wed, 15 Sep 2004 13:38:36 -0700 (PDT)
From: Ram Pai <linuxram@us.ibm.com>
X-X-Sender: ram@dyn319181.beaverton.ibm.com
Reply-To: linuxram@us.ibm.com
To: linux-kernel@vger.kernel.org
cc: pbadari@us.ibm.com, <akpm@osdl.org>
Subject: DSS regression on 2.6.9-rc2
Message-ID: <Pine.LNX.4.44.0409151316450.5161-100000@dyn319181.beaverton.ibm.com>
Organization: IBM Linux Technology Center
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The DSS performance has regressed by 11% on 2.6.9-rc2
We are investigating. Any ideas?

However sysbench and iozone show better results.

http://eaglet.rain.com/ram/Readahead.html 
has the progress graphs for the results of 2.6.* kernel series.

I plan to keep these graphs up2date across releases.
And add more readahead relevent benchmarks in the tracking list.

Thanks,
RP


