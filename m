Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265657AbTAJTqo>; Fri, 10 Jan 2003 14:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbTAJTqn>; Fri, 10 Jan 2003 14:46:43 -0500
Received: from adsl-67-113-154-34.dsl.sntc01.pacbell.net ([67.113.154.34]:8948
	"EHLO postbox.aslab.com") by vger.kernel.org with ESMTP
	id <S265657AbTAJTqn>; Fri, 10 Jan 2003 14:46:43 -0500
Message-ID: <3E1F2562.5040105@aslab.com>
Date: Fri, 10 Jan 2003 11:56:18 -0800
From: Michael Madore <mmadore@aslab.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-pre3-ac3 oops with himem 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I received the following oops while running the Cerberus stress test 
on 2.4.21-pre3-ac3.  The  hardware is an ASUS A7N8X  single AMD Athlon XP
 > motherboard with the Nvidia nforce2 chipset.  The oops occurs as soon 
as the system has used all the RAM and tries to use swap.  The total 
amount of
 > memory on the machine is 1GB, and himem is enabled.  If I turn off 
himem support the kernel starts to use swap without oopsing.  I can 
provide my
 > kernel .config or more hardware details if that would be useful.

Sorry for a little misinformation.  I seem to get the oops with himem 
disabled as well.  I must have just been lucky the first time.

Mike

