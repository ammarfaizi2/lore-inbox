Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265920AbRGAVOj>; Sun, 1 Jul 2001 17:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265926AbRGAVO3>; Sun, 1 Jul 2001 17:14:29 -0400
Received: from www.bebits.com ([208.245.212.78]:64014 "EHLO
	marvin.fifthace.com") by vger.kernel.org with ESMTP
	id <S265920AbRGAVOW>; Sun, 1 Jul 2001 17:14:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Seth Hartbecke <seth@sethstoybox.org>
To: linux-kernel@vger.kernel.org
Subject: My summer project: XMLFS
Date: Sun, 1 Jul 2001 16:11:43 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01070116114307.23785@myst>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For quite some time now I've wanted to try and do something in the kernel.  
And I need a simple project to start with, so I decided to create a 
filesystem that reads and writes to a XML file.  It's really basic right now 
(does not support permissions, but that should not be too hard to add) and 
does not like XML files with errors in them.

If any of you want to try it (and possibly lock your system in the process) 
you can download it from http://sethstoybox.org/projects/xmlfs/xmlfs.tgz.  
I've had it compile under 2.4.2, 2.4.3, 2.4.5 on Debian and Mandrake systems.

I know it's kinda pointless (and really silly to put an XML parser in the 
kernel), but I had fun.  Comments (outside of "this is totally stupid") are 
greatly appreciated.

thanks
l8r
Seth Hartbecke
-- 
A man that would sacrifice his freedom for security deserves neither.
				-- Charles Louis de Secundat, 1774
