Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313162AbSC2CVJ>; Thu, 28 Mar 2002 21:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313186AbSC2CU7>; Thu, 28 Mar 2002 21:20:59 -0500
Received: from irwanhadi.dorms.usu.edu ([129.123.230.12]:4736 "HELO
	irwanhadi.dorms.usu.edu") by vger.kernel.org with SMTP
	id <S313162AbSC2CUo>; Thu, 28 Mar 2002 21:20:44 -0500
Date: Thu, 28 Mar 2002 19:17:05 -0700
From: Irwan Hadi <irwanhadi@phxby.com>
To: linux-kernel@vger.kernel.org
Subject: Having too many access lists in Linux
Message-ID: <20020328191705.C17277@phxby.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I just curious (since I haven't tried this), what happened to linux (the
kernel especially), when a Linux Box has for example 100 access lists,
500 access lists, 1000 access lists, etc ?
Will I see a process consuming 100% of CPU Resources, or people will
feeling much slower when they are accessing my server, or the box starts
dropping some packets ?

(what I meant access lists is the TCP filtering managed thru ipchains,
iptables, etc.)
