Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284462AbRLEQie>; Wed, 5 Dec 2001 11:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284469AbRLEQiZ>; Wed, 5 Dec 2001 11:38:25 -0500
Received: from host213-121-104-31.in-addr.btopenworld.com ([213.121.104.31]:1454
	"HELO mail.dark.lan") by vger.kernel.org with SMTP
	id <S284462AbRLEQiD>; Wed, 5 Dec 2001 11:38:03 -0500
Subject: hang mounting cdrom on SMP and UP kernels...
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 05 Dec 2001 16:37:08 +0000
Message-Id: <1007570228.15255.0.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can repeatably hang Linux 2.4.9 simply by mounting a cdrom (ide). It's
a dual CPU machine but hangs with UP and SMP kernels. It affects 2 of
our machines (same model, a dell poweredge something or other). The hang
appears quite hard (keyboard lights stop working etc..).

Has anyone else encountered this?

I plan to test on newer kernels but probably won't have chance until
tomorrow...

Kind regards

-- 
// Gianni Tedesco <gianni@ecsc.co.uk>
80% of all email is a figment of procmails imagination.

