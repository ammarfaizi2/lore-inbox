Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262883AbTCSBhb>; Tue, 18 Mar 2003 20:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262884AbTCSBhb>; Tue, 18 Mar 2003 20:37:31 -0500
Received: from smtp-out.comcast.net ([24.153.64.116]:14325 "EHLO
	smtp.comcast.net") by vger.kernel.org with ESMTP id <S262883AbTCSBha>;
	Tue, 18 Mar 2003 20:37:30 -0500
Date: Tue, 18 Mar 2003 20:44:19 -0500
From: Tom Vier <tmv@comcast.net>
Subject: alpha fails Re: 2.4.20 ptrace patch
In-reply-to: <Pine.LNX.4.51.0303171141010.27605@skuld.mtroyal.ab.ca>
To: linux-kernel@vger.kernel.org
Reply-to: Tom Vier <tmv@comcast.net>
Message-id: <20030319014419.GA391@zero>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.3i
References: <Pine.LNX.4.51.0303171141010.27605@skuld.mtroyal.ab.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anyone have a quick fix?

kernel/kernel.o(.text+0x3488): In function `kernel_thread':
: undefined reference to `arch_kernel_thread'
kernel/kernel.o(.text+0x3490): In function `kernel_thread':
: undefined reference to `arch_kernel_thread'
make: *** [vmlinux] Error 1

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0xE6CB97DA
