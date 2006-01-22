Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWAVOU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWAVOU2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 09:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWAVOU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 09:20:28 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:12418 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751152AbWAVOU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 09:20:27 -0500
Date: Sun, 22 Jan 2006 09:18:42 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.16-rc1-mm2
To: Andrew Morton <akpm@osdl.org>
Cc: JANAK DESAI <janak@us.ibm.com>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601220920_MC3-1-B660-EE1C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060120031555.7b6d65b7.akpm@osdl.org>

The 'unshare' syscall is number 308 on x86-64's ia32 emulation and 310
on native i386.

These must be identical or Bad Things will happen.

-- 
Chuck
