Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbTIITIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTIITIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:08:35 -0400
Received: from smtp01.web.de ([217.72.192.180]:60942 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S264257AbTIITIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:08:34 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: linux-kernel@vger.kernel.org
Subject: inode generation numbers
Date: Tue, 9 Sep 2003 21:08:37 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309092108.37805.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

for a user space nfs-daemon it would be helpful to get the inode generation 
numbers. However it seems the fstat() from the glibc doesn't support this, 
but refering to some google search fstat() from some (not all) other unixes 
does.
Does anyone know how to read those numbers from userspace with linux?

Thanks,
	Bernd

