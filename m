Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267315AbSKPR2U>; Sat, 16 Nov 2002 12:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267316AbSKPR2U>; Sat, 16 Nov 2002 12:28:20 -0500
Received: from marcie.netcarrier.net ([216.178.72.21]:31760 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S267315AbSKPR2T>; Sat, 16 Nov 2002 12:28:19 -0500
Message-ID: <3DD6835E.D894FEFA@compuserve.com>
Date: Sat, 16 Nov 2002 12:41:50 -0500
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: bk current - new module build failures
Content-Type: multipart/mixed;
 boundary="------------81D7017ECAD6EF3207683393"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------81D7017ECAD6EF3207683393
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The attached module build failures are new since 2.5.46...

-- 
Kevin
--------------81D7017ECAD6EF3207683393
Content-Type: text/plain; charset=us-ascii;
 name="bk_current_be"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bk_current_be"

drivers/net/depca.c:2048: redefinition of `__module_name'
drivers/net/depca.c:469: `__module_name' previously defined here
{standard input}: Assembler messages:
{standard input}:3772: Error: symbol `__module_name' is already defined
make[2]: *** [drivers/net/depca.o] Error 1

net/wanrouter/wanmain.c:224: redefinition of `__module_name'
net/wanrouter/wanmain.c:130: `__module_name' previously defined here
{standard input}: Assembler messages:
{standard input}:43: Error: symbol `__module_name' is already defined
make[2]: *** [net/wanrouter/wanmain.o] Error 1

--------------81D7017ECAD6EF3207683393--

