Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265396AbTLRXNs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 18:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265400AbTLRXNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 18:13:47 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:33956 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S265396AbTLRXNq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 18:13:46 -0500
Date: Thu, 18 Dec 2003 18:11:37 -0500
To: linux-kernel@vger.kernel.org
Subject: [OT] use of patented algorithms in the kernel ok or not?
Message-ID: <20031218231137.GA13652@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Lennert Buytenhek <buytenh@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Apologies for posting this OT question here, I didn't find this question
answered in the FAQ.

There's a fast algorithm for longest-prefix match (as used in IPv4 routing
table lookups) which I have implemented, and would like to submit for
inclusion into the kernel (when 2.7 opens.)

However, I am aware that there is a patent on this algorithm, exclusively
licensed to a major manufacturer of networking equipment.

What am I to do?  Ignore the patent?  Or should I refrain from submitting
the patch I wrote, and look for an unencumbered algorithm instead?


thanks,
Lennert
