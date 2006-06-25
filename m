Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWFYPWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWFYPWj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 11:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWFYPWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 11:22:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:52112 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751439AbWFYPWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 11:22:38 -0400
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@google.com>
Subject: Re: [RFC, patch] i386: vgetcpu() for NUMA, take 2
Date: Sun, 25 Jun 2006 17:19:35 +0200
User-Agent: KMail/1.9.3
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Rohit Seth <rohitseth@google.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
References: <200606240426_MC3-1-C354-E4BC@compuserve.com> <449D5C21.5060600@google.com>
In-Reply-To: <449D5C21.5060600@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606251719.35479.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What was the point of returning wrong info to userspace really quickly?

Read the long rationale in my original vgetcpu() post.

-Andi
