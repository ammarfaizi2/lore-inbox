Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311866AbSCXWLZ>; Sun, 24 Mar 2002 17:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312081AbSCXWLP>; Sun, 24 Mar 2002 17:11:15 -0500
Received: from hofw1.ceridian.ca ([206.186.27.2]:32978 "EHLO mail.ceridian.ca")
	by vger.kernel.org with ESMTP id <S311866AbSCXWLK>;
	Sun, 24 Mar 2002 17:11:10 -0500
Subject: inode-max missing?
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.6a  January 17, 2001
Message-ID: <OFF1E4D08F.3F7F86A6-ON86256B86.0079B50E@ho.ceridian.ca>
From: John_Delisle@Ceridian.ca
Date: Sun, 24 Mar 2002 16:09:43 -0600
X-MIMETrack: Serialize by Router on SvrNotesMain/Comcheq(Release 5.0.5 |September 22, 2000) at
 2002/03/24 04:11:06 PM
MIME-Version: 1.0
Content-type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to fix a problem "too many open files" by adjusting
/proc/sys/fs/inode-max but I don't have one, it's missing.  I've gone
through the docs and they all reference it, but it's missing from parts of
the source susch as sysctl.c.

I'm running 2.4.18, btw.

Any help would be appreciated.

Thanks!

John Delisle
Corporate Technology
Ceridian Canada Ltd
204-975-5909



**********************************************************************
This e-mail and any files transmitted with it are considered 
confidential and are intended solely for the use of the 
individual or entity to whom they are addressed (intended).  
This communication is subject to agent/client privilege. 
If you are not the intended recipient (received in error) or 
the person responsible for delivering the e-mail to the 
intended recipient, be advised that you have received this 
e-mail in error and that any use, dissemination, forwarding, 
printing or copying of this e-mail is strictly prohibited.  If 
you have received this e-mail in error please notify the 
sender immediately.

**********************************************************************

