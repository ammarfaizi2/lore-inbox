Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbTLZA5n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 19:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbTLZA5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 19:57:43 -0500
Received: from mail.nvc.net ([64.68.160.43]:20484 "EHLO garbanzo.nvc.net")
	by vger.kernel.org with ESMTP id S264411AbTLZA5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 19:57:42 -0500
Message-ID: <3FEB8785.6070404@dakotainet.net>
Date: Thu, 25 Dec 2003 18:57:41 -0600
From: merwan kashouty <kashouty@dakotainet.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mpt-fusion driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i bought a  new scsi controller , lsi21320 and was running 2.4.23 , 
after about 20 hrs the system became sluggish and then locked up... i 
switched back to a tekram u160 card i had and after a few days found this.

http://www.ussg.iu.edu/hypermail/linux/kernel/0310.3/0068.html

in the messege is a link to a driver update released by lsi

ftp://ftp.lsil.com/HostAdapterDrivers/linux/Fusion-MPT/2.05.10/mptlinux-2.05

so i applied the updated driver patch to my kernel recompiled and its 
been running great ever since.. very fast too....

 Timing buffered disk reads:  316 MB in  3.02 seconds = 104.77 MB/sec

could this possibly find its way into the 2.4.23 or atleast 2.4.24 if it 
isnt already.

ciao

merwan

i am not a subscriber to the lkml so CC me if not to much trouble
