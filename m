Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTEJUFY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 16:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264491AbTEJUFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 16:05:24 -0400
Received: from sc-outsmtp2.homechoice.co.uk ([81.1.65.36]:30989 "HELO
	sc-outsmtp2.homechoice.co.uk") by vger.kernel.org with SMTP
	id S264490AbTEJUFX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 16:05:23 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: inode values in file system driver
Date: Sat, 10 May 2003 21:18:20 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200305102118.20318.adrian@mcmen.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am I allowed to assign the value 0 to an inode in a file system driver? I seem 
to be having problems with a file that is being assigned this inode value 
(its a FAT based filesystem so the inode values are totally artificial).

Adrian McMenamin
