Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132770AbRDNHKN>; Sat, 14 Apr 2001 03:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132774AbRDNHKD>; Sat, 14 Apr 2001 03:10:03 -0400
Received: from cogent.ecohler.net ([216.135.202.106]:65218 "EHLO
	cogent.ecohler.net") by vger.kernel.org with ESMTP
	id <S132770AbRDNHJ7>; Sat, 14 Apr 2001 03:09:59 -0400
Date: Sat, 14 Apr 2001 03:09:44 -0400
From: lists@sapience.com
To: linux-kernel@vger.kernel.org
Cc: gibbs@scsiguy.com
Subject: aicxxx and ac6 - works
Message-ID: <20010414030943.A20549@sapience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  After all the earlier difficulties booting off scsi disk I am delighted to report
  that it worked with ac6. 

  I must confess I did change one thing and that was to turn off SMP and turn on 
  IO-APIC for UP. I dont know if this is related or not as I have not tried 
  going back the other way.  The box in question is a single CPU machine (dell xps-t).  

  I also note that this version includes 6.1.11 of the aicxxx driver. 

  Thanks!


  regards,


 
  gene/
  

  
  
