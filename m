Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbUC0QTv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 11:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbUC0QTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 11:19:51 -0500
Received: from muss.CIS.mcmaster.ca ([130.113.64.9]:4031 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261804AbUC0QTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 11:19:50 -0500
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: Warning linux-2.6.5-rc2-mm3 fs/smbfs/inode.c
Date: Sat, 27 Mar 2004 11:19:50 -0500
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403271119.50316.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 These warnings have been showing up ever since I can remember running 2.6 , 
(2.6.0 I believe) are these dangerous and are there any fixes yet?

 CC      fs/smbfs/inode.o
fs/smbfs/inode.c: In function `smb_fill_super':
fs/smbfs/inode.c:555: warning: comparison is always false due to limited range 
of data type
fs/smbfs/inode.c:556: warning: comparison is always false due to limited range 
of data type

Please CC me with any discussion.
-- 
Gabriel Devenyi
devenyga@mcmaster.ca
