Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265133AbUGHWel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265133AbUGHWel (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 18:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbUGHWel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 18:34:41 -0400
Received: from hera.ecs.csus.edu ([130.86.71.150]:53906 "EHLO
	hera.ecs.csus.edu") by vger.kernel.org with ESMTP id S265133AbUGHWek
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 18:34:40 -0400
Message-ID: <36266.68.126.187.236.1089326080.squirrel@gaia.ecs.csus.edu>
Date: Thu, 8 Jul 2004 15:34:40 -0700 (PDT)
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
