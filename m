Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319263AbSIFQui>; Fri, 6 Sep 2002 12:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319265AbSIFQui>; Fri, 6 Sep 2002 12:50:38 -0400
Received: from vulcan.americom.com ([208.187.207.195]:39923 "HELO
	solo.americom.com") by vger.kernel.org with SMTP id <S319263AbSIFQuh>;
	Fri, 6 Sep 2002 12:50:37 -0400
Date: 6 Sep 2002 16:55:16 -0000
Message-ID: <20020906165516.17282.qmail@solo.americom.com>
To: linux-kernel@vger.kernel.org
From: jeff@AmeriCom.com
Subject: Linux SMP kernel bug with > 512M ram
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been having problems with a few of our servers and I can't seem to find this 
problem mentioned anywhere else. All of the dual processor machines will not operate 
with greater than 512 megs of ram with the newer SMP kernels (2.4.7-10enterprise #1 
SMP). Two of the dual P3 1ghz machines crash after a few minutes, when the memory 
usage gets high enough, I presume. The errors they spit out vary, but its only when 
I go over 512megs of ram, and only on dual processor machines. I had a slightly 
different problem when I tried to set it up on a dual p2 266 machine, when I go over 
512 megs there, the system takes an hour to boot up, and everything crawls from 
there. I asked a friend of mine to try this newer kernel with his dual processor 
server, and he says the same thing (when I go over 512, it crashes). Has anybody had 
this problem? Is there a fix?

Regards,

Jeffrey Moss
jeff@americom.com






