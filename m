Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVCBLOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVCBLOr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 06:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVCBLOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 06:14:47 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:12623 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262263AbVCBLOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 06:14:46 -0500
Message-ID: <4225A020.5060001@yahoo.com.au>
Date: Wed, 02 Mar 2005 22:14:40 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] nicksched for 2.6.11
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had a few queries about this, so by "popular" demand, I've
put my latest nicksched stuff here:

www.kerneltrap.org/~npiggin/2.6.11-nicksched.gz

It includes all the multiprocessor stuff that's in -mm, and also
my alternate scheduler policy.

Nick

