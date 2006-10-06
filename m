Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWJFFkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWJFFkV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 01:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWJFFkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 01:40:21 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:3004 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932202AbWJFFkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 01:40:18 -0400
Date: Fri, 6 Oct 2006 07:39:56 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Really good idea to allow mmap(0, FIXED)?
In-Reply-To: <eg4624$be$1@taverner.cs.berkeley.edu>
Message-ID: <Pine.LNX.4.61.0610060739520.12702@yvahk01.tjqt.qr>
References: <200610052059.11714.mb@bu3sch.de> <eg4624$be$1@taverner.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>Is is really a good idea to allow processes to remap something
>>to address 0?
>>I say no, because this can potentially be used to turn rather harmless
>>kernel bugs into a security vulnerability.
>
>Let me see if I understand.  If the kernel does this somewhere:
[...]

For reference, please see http://lkml.org/lkml/2006/2/22/90


	-`J'
-- 
