Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136685AbREASLy>; Tue, 1 May 2001 14:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136684AbREASLm>; Tue, 1 May 2001 14:11:42 -0400
Received: from nwcst287.netaddress.usa.net ([204.68.23.32]:26337 "HELO
	nwcst287.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S136683AbREASLe> convert rfc822-to-8bit; Tue, 1 May 2001 14:11:34 -0400
Message-ID: <20010501181133.2486.qmail@nwcst287.netaddress.usa.net>
Date: 1 May 2001 13:11:33 CDT
From: shreenivasa H V <shreenihv@usa.net>
To: linux-kernel@vger.kernel.org
Subject: Compiling modules for kernel 2.4
X-MSMail-Priority: High
X-Priority: 1
X-Mailer: USANET web-mailer (34FM.0700.17C.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am having trouble compiling the modules for kernel 2.4. The compilation
doesn't go through, it just goes into each directory and says "nothing to do"
and comes out. The object files are not created. Has anyone else faced the
same problem? Do I have to do any other setup before doing

make mrproper config dep clean bzImage modules modules_install

I tried the same stuff with with kernel 2.2.16 and the modules compile fine.

thanks,
shreeni.

____________________________________________________________________
Get free email and a permanent address at http://www.netaddress.com/?N=1
