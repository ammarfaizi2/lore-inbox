Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269493AbUJLH30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269493AbUJLH30 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 03:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269500AbUJLH3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 03:29:25 -0400
Received: from [202.141.25.89] ([202.141.25.89]:36787 "EHLO
	cello.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S269493AbUJLH3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 03:29:24 -0400
To: linux-kernel@vger.kernel.org
Subject: swsusp freezes
From: Rajsekar <raj--DeleteMe--sekar@peacock.METOO.ernet.in>
Date: Tue, 12 Oct 2004 12:57:13 +0530
Message-ID: <y49d5zoz99q.fsf@sahana.cs.iitm.ernet.in>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am using 2.6.8-rc4-mm1 kernel at my home.  When I try to swap suspend
(either using swsusp or pmdisk) it figures out how much memory is required
and all and then sometimes freezes giving a backtrace.  I am interested in
debugging this problem.  Can someone tell me the basic things required
(softwares and some docs if any) to debug such kernel codes.  This is my
first venture into debugging kernel codes, so I am very much a newbie.

Thank you
-- 
    Rajsekar

