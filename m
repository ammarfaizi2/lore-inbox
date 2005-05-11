Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVEKQnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVEKQnb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 12:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVEKQnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 12:43:31 -0400
Received: from lantana.tenet.res.in ([202.144.28.166]:8401 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S261230AbVEKQnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 12:43:22 -0400
Date: Wed, 11 May 2005 22:13:57 +0530 (IST)
From: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: ioctl to keyboard device file.
Message-ID: <Pine.LNX.4.60.0505112207300.21632@lantana.cs.iitm.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hai,
      I want to add a new ioctl to keyboard driver device file which will 
perform the work of copying user space data  sent to it into kernel 
space and send those characters  to handle_scancode function of keyboard 
driver.. Now I want to know

1) what is the device file corresponding to keyboard (is it 
/dev/input/keyboard).
2) where file operations structure is defined for that.
3) where the those ioctls handled(not found in keyboard.c).

Any small help is appreciated.


   Thanks&Regards,
   P.Manohar,
