Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313823AbSDPSyW>; Tue, 16 Apr 2002 14:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313824AbSDPSyV>; Tue, 16 Apr 2002 14:54:21 -0400
Received: from web13208.mail.yahoo.com ([216.136.174.193]:49169 "HELO
	web13208.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313823AbSDPSyU>; Tue, 16 Apr 2002 14:54:20 -0400
Message-ID: <20020416185419.52395.qmail@web13208.mail.yahoo.com>
Date: Tue, 16 Apr 2002 11:54:19 -0700 (PDT)
From: "X.Xiao" <joyhaa@yahoo.com>
Subject: tcp/ip stack in user space
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i want to move tcp/ip stack(including routing and
netfilter) to userspace, my goal is to trace all the
instructions involved in a firewall and router since i
don't know how to trace these instructions inside the
kernel. i want to get something like:

incoming ip packets(a file)-->fake ISR-->tcp/ip
stack-->outgoing ip packets( to /dev/null).

my question is: is it possible and relatively easy to
move tcp/ip stack to user space?

thanks for help.

X.Xiao

__________________________________________________
Do You Yahoo!?
Yahoo! Tax Center - online filing with TurboTax
http://taxes.yahoo.com/
