Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267097AbTBHU0O>; Sat, 8 Feb 2003 15:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267103AbTBHU0O>; Sat, 8 Feb 2003 15:26:14 -0500
Received: from franka.aracnet.com ([216.99.193.44]:54457 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267097AbTBHU0M>; Sat, 8 Feb 2003 15:26:12 -0500
Date: Sat, 08 Feb 2003 12:35:51 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 329] New: wheel doesn't works on a usb mouse (fwd)
Message-ID: <20880000.1044736551@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=329

           Summary: wheel doesn't works on a usb mouse
    Kernel Version: 2.5.59-bk2
            Status: NEW
          Severity: low
             Owner: vojtech@suse.cz
         Submitter: tamaguci@katamail.com


Distribution: debian sid  
Hardware Environment: via kt-400, athlon xp 2000 
Problem Description: 
I have a logitech optical usb mouse, 
the problem is that the 2.5.59-bk2 kernel doesn't see the wheel 
(on the same system, the wheel works perfectly under 2.4.21-pre4). 
I noticed that trying to "cat /proc/input/mice" while moving the 
mouse return some strange symbol unless i try to move the wheel. 
 
Steps to reproduce: 
plug in the mouse :-) 
 
ps I use devfs support.

