Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264180AbTE0VN6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264177AbTE0VNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:13:52 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:59129 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264189AbTE0VMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:12:12 -0400
Date: Tue, 27 May 2003 17:25:25 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200305272125.h4RLPPl18360@devserv.devel.redhat.com>
To: Ricky Beam <jfbeam@bluetronic.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70
In-Reply-To: <mailman.1054055041.7585.linux-kernel2news@redhat.com>
References: <mailman.1054055041.7585.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...]
> Take a look at the number of arch's that haven't seen much testing (and
> in many respects are thus broken)... does anyone have a functional 2.5.70
> sparc64 kernel?  I've built several but they're all too big to be booted
> (i.e. over 3.5M, and yes, I've turned off everything possible.)

The topic of architectures being behind was discussed in the
context of AKPM's must-fix list, before Hanna's #lse call.
The decision is to go ahead with first tier architectures only.
Please deal with it.

-- Pete
