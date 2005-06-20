Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVFTBor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVFTBor (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 21:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVFTBor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 21:44:47 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:17176 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261370AbVFTBob convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 21:44:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PQggpBg9SJiurNPJQoah8/JVH33qb2sjyOAQ1Bb9Iyc0OOtWlZIzSg11/oSeFljL8/t2nIm/K+MVNGi1MkSAk6Ibje2HIBIjg8Rat2soXZ1cBM80u8USM8vgr4kHQ6fw1PZ7gxzZxNHiYCA6+y/IcKqB79lOpEm8hma7k06DF1g=
Message-ID: <d73ab4d005061918441ae4a81f@mail.gmail.com>
Date: Mon, 20 Jun 2005 09:44:30 +0800
From: guorke <gourke@gmail.com>
Reply-To: guorke <gourke@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Hi,make question
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,when complie 2.6.12,i meet the followning message,how to fix it?

ipc/shm.c: In function `shm_inc':
ipc/shm.c:99: internal error: Segmentation fault
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.
make[1]: *** [ipc/shm.o] Error 1
make: *** [ipc] Error 2

thanks
