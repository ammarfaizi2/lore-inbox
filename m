Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266586AbUBLXrG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 18:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266587AbUBLXrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 18:47:06 -0500
Received: from muss.CIS.McMaster.CA ([130.113.64.9]:34949 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S266586AbUBLXrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 18:47:03 -0500
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Linux 2.6.3-rc2-mm1 in fs/smbfs/inode.c
Date: Thu, 12 Feb 2004 18:45:24 -0500
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402121845.24144.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one has been around for a while, since at least 2.6.0.
 
 CC      fs/smbfs/inode.o
fs/smbfs/inode.c: In function `smb_fill_super': 
fs/smbfs/inode.c:554: warning: comparison is always false due to limited range 
of data type
fs/smbfs/inode.c:555: warning: comparison is always false due to limited range 
of data type


Please CC me with any replies as I am not subcribed

Gabriel Devenyi
devenyga@mcmaster.ca
