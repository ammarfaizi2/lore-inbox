Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264481AbUBRQa2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 11:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266510AbUBRQa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 11:30:27 -0500
Received: from ee.oulu.fi ([130.231.61.23]:49106 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S264481AbUBRQaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 11:30:25 -0500
Date: Wed, 18 Feb 2004 18:30:15 +0200
From: Flexy <flexy@ee.oulu.fi>
To: linux-kernel@vger.kernel.org
Subject: Laptop problems with 2.4 & 2.6 (HP Omnibook 4150)
Message-ID: <20040218163015.GA10416@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.4.23 kernel, keventd is not using much CPU time, but on 2.4.25-pre8 
keventd is taking upto same amount as X. The difference is atleast a 
decade or two. The configurations of these kernels are the same.

On 2.6.3 kernel, events/0 is taking CPU time, much like keventd in 
2.4.25-pre8.

I'm using vanilla kernels from kernel.org on HP Omnibook 4150, PIII 500, 
with BX chipset. 256MB memory, 3c589_cs.

I'm happy to provide any additional information and do some testing, 
if needed. Remember to put me on cc-list, I'm not subscribed.

TIA,

Flexy
