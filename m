Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263185AbTCLOHu>; Wed, 12 Mar 2003 09:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263186AbTCLOHu>; Wed, 12 Mar 2003 09:07:50 -0500
Received: from amdext2.amd.com ([163.181.251.1]:59788 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id <S263185AbTCLOHs>;
	Wed, 12 Mar 2003 09:07:48 -0500
X-Server-Uuid: 262C4BA7-64EE-471D-8B02-117625D613AB
Date: Wed, 12 Mar 2003 08:18:21 -0600
From: "Donald Zoch" <donald.zoch@amd.com>
To: linux-kernel@vger.kernel.org
cc: "Donald Zoch" <donald.zoch@amd.com>
Subject: module to detect sigsegv
Message-ID: <20030312081821.G12608@lard.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.3.20i
X-WSS-ID: 12719E3B3277940-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm new to kernel programming and have set the goal of writing
a kernel module to detect signal 11 errors and log them.  
My question is what is the best way to attack this in a module? 
I've figured out how to write a basic module, but I'm having a
hard time figuring out how to do the checking.
How can I look at every signal that the kernel sends to processes
and pick out those that I want to report on? 

Apologies for sending this to the main list.  kernelnewbies doesn't
seem to be working any longer.

Thanks,

Donald

