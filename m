Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263848AbTEFPh4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263855AbTEFPh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:37:56 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:1028 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S263848AbTEFPhz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:37:55 -0400
Date: Tue, 6 May 2003 11:50:22 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: X unlock bug revisited
Message-ID: <Pine.LNX.4.44.0305061141300.1272-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some months ago I noted that a new kernel introduced a failure to be able 
to unlock X after locking. Still there in 2.5.69 for RH 7.2, 7.3, and 8.0.

Is there any plan to address whatever causes this problem with a kernel 
fix, or is a 2.4 kernel still the way to go if you need to lock X. I 
realize many developers work in environments where there's no need.

