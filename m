Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264650AbUGIOVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264650AbUGIOVJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 10:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUGIOVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 10:21:09 -0400
Received: from hera.ecs.csus.edu ([130.86.71.150]:60058 "EHLO
	hera.ecs.csus.edu") by vger.kernel.org with ESMTP id S264650AbUGIOVH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 10:21:07 -0400
Message-ID: <48088.68.126.187.236.1089382866.squirrel@gaia.ecs.csus.edu>
Date: Fri, 9 Jul 2004 07:21:06 -0700 (PDT)
Subject: 2.6.6 kernel memory space
From: sirpj@ecs.csus.edu
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have found a lot of documentation on how linux is addressing the 4 gig
issue... But what I would like to know is how much space does the kernel
have to run a kernel process? For example, if I build a module that
allocates storage for a linked list of structures (that are 64 bytes in
size) how long can my list be before the kernel runs out of memory? Can
kernel space programs use Virtual Memory -- or do they just have access to
1 GB?

thanks a lot,

Jenn


