Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131424AbRC3NvD>; Fri, 30 Mar 2001 08:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbRC3Nux>; Fri, 30 Mar 2001 08:50:53 -0500
Received: from unimur.um.es ([155.54.1.1]:63386 "EHLO unimur.um.es")
	by vger.kernel.org with ESMTP id <S131424AbRC3Nul>;
	Fri, 30 Mar 2001 08:50:41 -0500
Date: Fri, 30 Mar 2001 15:55:01 +0200 (CEST)
From: Juan Piernas Canovas <piernas@ditec.um.es>
To: linux-kernel@vger.kernel.org
Subject: 2.2.19 && ppa: total lockup. No problem with 2.2.17
In-Reply-To: <Pine.LNX.4.21.0103301519370.13429@ditec.um.es>
Message-ID: <Pine.LNX.4.21.0103301554310.14247-100000@ditec.um.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2001, Juan Piernas Canovas wrote:

Hi!.
 
When I execute "modprobe ppa" while running a kernel 2.2.19, my computer
hangs completely. No messages. System request key does not work.
 
The kernel configuration is the same in both 2.2.17 and 2.2.19.
Perhaps, the problem is not in the ppa module, but in the parport,
parport_pc or parport_probe modules.
 
Bye!
 
	Juan.
 
 
 

