Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbTBERkd>; Wed, 5 Feb 2003 12:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbTBERkc>; Wed, 5 Feb 2003 12:40:32 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:57816 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262190AbTBERkc>; Wed, 5 Feb 2003 12:40:32 -0500
Importance: Normal
Sensitivity: 
Subject: [CHECKER] 112 potential memory leaks in 2.5.48
To: Andy Chou <acc@CS.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF943B9F50.57703787-ON87256CC4.00617A8B@us.ibm.com>
From: Steven French <sfrench@us.ibm.com>
Date: Wed, 5 Feb 2003 11:48:36 -0600
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 6.0 [IBM]|December 16, 2002) at
 02/05/2003 10:49:36
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Andy,
Yes you are correct about a memory leak being in fs/cifs/transport.c in 2.5
I have included the fix for this in version 0.6.3 of the CIFS VFS which is
being
tested now and will post the patch for version 0.6.3 to the project web
site
(http://us1.samba.org/samba/Linux_CIFS_client.html) later today.

Thanks for finding this.

Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench@us.ibm.com

