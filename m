Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbTJITLL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 15:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbTJITLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 15:11:11 -0400
Received: from topaz-57.mcs.anl.gov ([140.221.57.209]:18819 "EHLO topaz")
	by vger.kernel.org with ESMTP id S262403AbTJITLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 15:11:10 -0400
To: linux-kernel@vger.kernel.org
Subject: pmdisk performance problem
From: Narayan Desai <desai@mcs.anl.gov>
Date: Thu, 09 Oct 2003 14:11:06 -0500
Message-ID: <87k77ejkfp.fsf@mcs.anl.gov>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using 2.6.0-test7 on an ibm thinkpad t21, pmdisk works properly,
though it takes quite a while to write out pages to disk. On my last
suspend to disk, it took on the order of 8-10 minutes. After this
completed, i was able to successfully resume, fairly speedily, however
my hardware clock was 8-10 minutes behind. Does anyone have any ideas
why this is happening? thanks...
 -nld
