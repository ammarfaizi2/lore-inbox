Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130818AbRCFBTP>; Mon, 5 Mar 2001 20:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130819AbRCFBTF>; Mon, 5 Mar 2001 20:19:05 -0500
Received: from gw-us4.philips.com ([63.114.235.90]:32525 "EHLO
	gw-us4.philips.com") by vger.kernel.org with ESMTP
	id <S130818AbRCFBSt> convert rfc822-to-8bit; Mon, 5 Mar 2001 20:18:49 -0500
From: steve.snyder@philips.com
To: <linux-kernel@vger.kernel.org>
Subject: How-To for PPPoE in v2.4.x?
Message-ID: <0056910010694057000002L172*@MHS>
Date: Mon, 5 Mar 2001 19:20:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	name="MEMO 03/05/01 19:18:25"
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a How-To for getting the Linux v2.4.x PPPoE support to work?  
I've searched for info but have mostly found sketchy references on getting 
PPPoE to work with the v2.2 kernel.  

My system is running RedHat v6.2 and the v2.4.2 Linux kernel.  I've built 
PPP and PPPoE support into the kernel and I've installed the v2.4.0 PPP 
software.  I've got the /dev/ppp created by the RedHat installation and I 
see "pppoe" in the /proc/drivers list of drivers.  

I've got a (PCMCIA-based) NIC that I know works as a plain non-PPPoE 
device under v2.4.x.  

So what do I do now?  Do I have to patch pppd to utilize the kernel's 
new PPPoE support?  Do I have to create a /dev/pppoe devnode?

While I have a lot of experience with Ethernet networking on Linux, I am a     
total PPP (let alone PPPoE) newbie.  Please be gentle.  :-)

Thank you.
