Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267872AbRGRNHB>; Wed, 18 Jul 2001 09:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267873AbRGRNGw>; Wed, 18 Jul 2001 09:06:52 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:38900 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S267872AbRGRNGm>; Wed, 18 Jul 2001 09:06:42 -0400
From: mdaljeet@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA256A8D.0047BE63.00@d73mta01.au.ibm.com>
Date: Wed, 18 Jul 2001 18:31:25 +0530
Subject: ppc Linux-2.4.2 not generating core dump for SIGSEGV and abort()
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
     I am using Suse-linux-7.1 with default linux -ppc kernel on apple G4
machine.
SIGSEGV is never generating the core dump. though this signal is being
caught by the user process.
I also tried with "abort" call which should generate the core dump, but
this is also not working. The same program with abort call is generating
core dumps on other linux/unix platforms.
Can anybody tell me where is the problem?

Daljeet.


