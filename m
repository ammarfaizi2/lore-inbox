Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291878AbSCDGiI>; Mon, 4 Mar 2002 01:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291944AbSCDGh6>; Mon, 4 Mar 2002 01:37:58 -0500
Received: from barkley.vpha.health.ufl.edu ([159.178.78.160]:8907 "EHLO
	barkley.vpha.health.ufl.edu") by vger.kernel.org with ESMTP
	id <S291878AbSCDGho>; Mon, 4 Mar 2002 01:37:44 -0500
Message-ID: <1015223869.3c83163d70e28@webmail.health.ufl.edu>
Date: Mon,  4 Mar 2002 01:37:49 -0500
From: sridharv@ufl.edu
To: linux-kernel@vger.kernel.org
Subject: idle threads - SMP 
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 66.157.144.214
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

can someone throw more light on idle threads. I was trying to understand the 
SMP bootup code.what exactly is  the diff between a kernel thread and an idle 
thread? in SMP is every CPU associated with an idle thread?pl clarify. also a 
little bit of info on trampoline.s is welcome :-). 
-sridhar

