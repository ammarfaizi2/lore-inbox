Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292005AbSBOASW>; Thu, 14 Feb 2002 19:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292021AbSBOASM>; Thu, 14 Feb 2002 19:18:12 -0500
Received: from [64.169.83.2] ([64.169.83.2]:2308 "EHLO mail.get2chip.com")
	by vger.kernel.org with ESMTP id <S292005AbSBOASK>;
	Thu, 14 Feb 2002 19:18:10 -0500
Message-ID: <3C6C53C0.E7562704@get2chip.com>
Date: Thu, 14 Feb 2002 16:18:08 -0800
From: ccroswhite@get2chip.com
Reply-To: ccroswhite@get2chip.com
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with VM
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having difficulties with memory allocation in  teh 2.4.17 kernel.
Memory is being agressively given as cache but not retrieved to be used
as 'normal' ran.  Consequently, I will have a machine that has 5M
'normal' RAM, 800M 'cache' RAM and the reset coming out of swap space.
I need this 'cache' RAM placed back into the available RAM pool to be
used by applications.  Is there a patch/kernel configuration that I can
change this behavior?

Chris Croswhite
Get2Chip, Inc.

