Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268712AbUHTUHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268712AbUHTUHl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268696AbUHTUFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:05:10 -0400
Received: from mail2.speakeasy.net ([216.254.0.202]:9702 "EHLO
	mail2.speakeasy.net") by vger.kernel.org with ESMTP id S268707AbUHTUEX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:04:23 -0400
Date: Fri, 20 Aug 2004 13:04:17 -0700
Message-Id: <200408202004.i7KK4HZN001285@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: "Michael Kerrisk" <mtk-lkml@gmx.net>
Cc: torvalds@osdl.org, akpm@osdl.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
Subject: Re: [PATCH] waitid system call
In-Reply-To: Michael Kerrisk's message of  Friday, 20 August 2004 11:02:36 +0200 <20310.1092992556@www22.gmx.net>
X-Shopping-List: (1) Raucous fingers
   (2) Weary ostentatious televangelist tape
   (3) Allergic cow fiction
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you give a complete specification of what these other systems do?
Do they zero the whole structure?  i.e., test by filling with recognizable
garbage, and then examine all the fields after the waitid call and tell me
what they are.


Thanks,
Roland
