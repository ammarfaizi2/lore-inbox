Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269706AbUJGFfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269706AbUJGFfm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 01:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269704AbUJGFfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 01:35:41 -0400
Received: from siaag2ag.compuserve.com ([149.174.40.140]:46156 "EHLO
	siaag2ag.compuserve.com") by vger.kernel.org with ESMTP
	id S269706AbUJGFeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 01:34:16 -0400
Date: Thu, 7 Oct 2004 01:31:39 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Why no linux-2.6.8.2? (was Re: new dev model)
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200410070134_MC3-1-8BA9-A215@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why has linux 2.6.8 been abandoned at version 2.6.8.1?

There exist fixes that could go into 2.6.8.2:

        process start time doesn't match system time
        FDDI frame doesn't allow 802.3 hwtype
        NFS server using XFS filesystem on SMP machine oopses

I'm sure there are more...

So why is 2.6.8.1 a "dead branch?"


--Chuck Ebbert


