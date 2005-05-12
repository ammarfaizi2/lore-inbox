Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVELEwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVELEwJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 00:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVELEwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 00:52:09 -0400
Received: from lantana.tenet.res.in ([202.144.28.166]:40832 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S261283AbVELEwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 00:52:05 -0400
Date: Thu, 12 May 2005 10:21:31 +0530 (IST)
From: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
To: linux-kernel@vger.kernel.org
cc: industeqsite@industeqsite.com
Message-ID: <Pine.LNX.4.60.0505121017090.31256@lantana.cs.iitm.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Subject: remote keyboard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


" I am planning to have remote keyboard to control the operations on a
  particular target. To explain in detail, I will have a PC with keyboard,
  mouse etc and this PC will be connected to another PC(Remote) via 
Ethernet.
Instead of using the local keyboard input, I want sent the keyboard keys
from the remote system (another PC via Ethernet) and use it as if it 
from
  the local keyboard.

My Plan
  I am planning to use the Linux keyboard driver and read the keyboard 
buffer
from the remote PC and send it to the target PC, and in the target PC
  whatever the key code I have received through the Ethernet I will put it
into the local keyboard buffer using the Linux keyboard driver IOCTLs.

  Can anybody tell me is this acceptable "


Hai,
    The above message appeared in kernel-mailing list,
  I am also involved in the same problem.
How to put characters into keyboard buffer using the Linux keyboard driver 
IOCTLs?

If anybody knows about it please guide me.

