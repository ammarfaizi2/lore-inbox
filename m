Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbUCPRwq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbUCPRwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 12:52:32 -0500
Received: from ool-43554ab1.dyn.optonline.net ([67.85.74.177]:28801 "EHLO
	nikolas.hn.org") by vger.kernel.org with ESMTP id S264324AbUCPRv5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 12:51:57 -0500
Date: Tue, 16 Mar 2004 12:51:56 -0500
From: Nick Orlov <bugfixer@list.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc1-mm1 hangs after Uncompressing kernel...
Message-ID: <20040316175156.GA11785@nikolas.hn.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.5-rc1-mm1 with 4k-stacks-always-on reverted hangs after
"Uncompressing kernel ..."

reverting early-x86-cpu-detection-fix solved the problem for me.

Box have Intel(R) Pentium(R) 4 CPU 3.20GHz with HT enabled.

Any additional info available by request.

Please CC me - I'm not subscribed to the list.

Thanks,
	Nick.
-- 
With best wishes,
	Nick Orlov.

